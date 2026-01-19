const path = require('path');
const webpack = require('webpack');

module.exports = {
  entry: {
    application: './app/javascript/application.js'
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'app/assets/builds'),
    clean: false
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    })
  ],
  resolve: {
    modules: [
      path.resolve(__dirname, 'app/javascript'),
      'node_modules'
    ]
  },
  optimization: {
    moduleIds: 'deterministic'
  }
};
