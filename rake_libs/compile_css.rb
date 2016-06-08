#TODO: Let's get some comments up here, please.
#TODO: We should probably explicity set the Autoprefixer browser versions, but
#      I'm not yet sure how far back we want to support.

def compile_css(debug: false)
  require 'sass'
  require 'autoprefixer-rails'

  options = {
    :syntax         => :scss,
    :cache          => true,
    :cache_location => $cache_dir,
    :load_paths     => [$css_source, "#{$css_source}/imports"],
    :style          => debug ? :expanded : :compressed,
    :line_comments  => debug ? true      : false,
    :full_exception => debug ? true      : false,
  }

  # Dir.glob("#{$css_source}/*.scss").each do |scss_file_path|
  Dir.glob("#{$css_source}/sandbox.scss").each do |scss_file_path|
    scss_file_name   = File.basename(scss_file_path)
    output_file_name = scss_file_name.gsub(/\.scss$/, ".css")
    output_file_path = "#{$css_dest}/#{output_file_name}"
    public_file_path = "#{$hugo_dest}/css/#{output_file_name}"

    # If we're running as debug, build the sourcemaps
    if debug
      (css_str, sass_map) = Sass::Engine.for_file(scss_file_path, options)
                            .render_with_sourcemap("#{output_file_name}.map")
      prefixed_results = AutoprefixerRails.process(css_str, {
        :map => {
          :prev => sass_map.to_json({
            :css_path       => public_file_path,
            :sourcemap_path => "#{public_file_path}.map",
          }),
          :inline => false,
        },
        :from => scss_file_path,
        :to   => public_file_path,
      })

      File.write(output_file_path, prefixed_results.css)
      log_write(output_file_path)
      File.write("#{output_file_path}.map", prefixed_results.map)
      log_write("#{output_file_path}.map")
    else
      css_str = Sass::Engine.for_file(scss_file_path, options).render
      prefixed_results = AutoprefixerRails.process(css_str, {
        :from => scss_file_path,
        :to   => public_file_path,
      })

      File.write(output_file_path, prefixed_results.css)
      log_write(output_file_path)
    end
  end
end
