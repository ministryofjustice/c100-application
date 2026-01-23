const path = require('path');
const webpack = require('webpack');

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: './app/javascript/application.js'
  },
  output: {
    filename: 'bundle.js',
    sourceMapFilename: "bundle.map",
    chunkFormat: "module",
    path: path.resolve(__dirname, 'app/assets/builds')
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
