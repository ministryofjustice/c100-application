Grover.configure do |config|
  # Production-optimized launch args for reliability and debugging
  production_args = [
    '--no-sandbox',
    '--disable-setuid-sandbox', 
    '--disable-gpu',
    '--font-render-hinting=medium',
    '--disable-web-security',          # May help with resource loading
    '--disable-features=TranslateUI',  # Disable translation popup
    '--disable-extensions',            # Disable extensions for stability
    '--disable-plugins',               # Disable plugins
    '--no-first-run',                  # Skip first-run setup
    '--disable-default-apps',          # Disable default apps
    '--disable-dev-shm-usage',         # Use /tmp instead of /dev/shm (Docker fix)
    '--single-process',                # Use single process mode for better memory management
  ]

  # Add memory and performance args for production
  if Rails.env.production?
    production_args += [
      '--memory-pressure-off',         # Disable memory pressure notifications
      '--max_old_space_size=4096',     # Increase Node.js heap size
      '--disable-background-timer-throttling', # Prevent timer throttling
    ]
  end

  config.options = {
    format: 'A4',
    display_header_footer: true,
    print_background: true,
    header_template: '.',
    margin: {
      top: '40px',
      left: '40px', 
      right: '40px',
      bottom: '70px'
    },
    launch_args: production_args,
    # Add wait conditions for better reliability
    wait_for_selector: 'body',         # Wait for body to be present
    wait_for_timeout: 5000,            # Wait 5 seconds for page load
    # Network and resource loading settings
    emulate_media: 'print',            # Use print CSS media
    viewport: {
      width: 1280,
      height: 1024,
      device_scale_factor: 1
    }
  }
end
