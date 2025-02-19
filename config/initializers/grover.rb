Grover.configure do |config|
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
    launch_args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-gpu','--font-render-hinting=medium'],
  }
end