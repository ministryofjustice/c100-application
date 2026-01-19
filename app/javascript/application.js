// jQuery is provided globally via webpack.ProvidePlugin
import './moj';
import './modules/session-timeout';
import './modules/ga-events';
import './modules/check-email-address';
import './modules/disable-enter-key';
import './modules/pdf-status';
import './pages/approx-dob';
import './pages/validate-file-size';
import './utils/set-input-filter';

// Initialize all modules when DOM is ready
$(document).ready(function() {
  window.moj.init();
});
