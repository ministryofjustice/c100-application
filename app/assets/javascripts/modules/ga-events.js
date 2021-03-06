'use strict';

moj.Modules.gaEvents = {
    radioFormClass: '.govuk-radios input[type="radio"]',
    checkboxClass:  '.govuk-checkboxes input[type="checkbox"]',
    linkClass: '.ga-pageLink',
    clickActionClass: '.ga-clickAction',
    revealingLinkClass: 'summary span',
    submitFormClass: '.ga-submitForm',
    submitButtons: 'button[type="submit"], input[type="submit"]',

    init: function () {
        var self = this;

        // don't bind anything if the GA object isn't defined
        if (typeof window.ga !== 'undefined') {
            // Some pesky side effect of unbinding/triggering the submit event in some of
            // the following functions, is the submit button value is lost from the params.
            // We use this value to know when the `Save and come back later` submit button
            // was used, instead of the normal `Continue` button.
            // Non-javascript browsers have no issues, will always send the submit value.
            if ($(self.submitButtons).length) {
                self.addSubmitValueParamOnClick();
            }
            if ($(self.radioFormClass).length) {
                self.trackRadioForms();
            }
            if ($(self.checkboxClass).length) {
                self.trackCheckboxes();
            }
            if ($(self.linkClass).length) {
                self.trackLinks();
            }
            if ($(self.revealingLinkClass).length) {
                self.trackRevealingLinks();
            }
            if ($(self.clickActionClass).length) {
                self.trackClickActions();
            }
            if ($(self.submitFormClass).length) {
                self.trackSubmitForms();
            }
            // External links, tracked as GA outbound events
            if ($("a[rel^=external]").length) {
                self.trackExternalLinks();
            }
        }
    },

    addSubmitValueParamOnClick: function() {
        $(this.submitButtons).on('click', function() {
            if ($(this).attr('name')) {
                $('<input>',
                    {type: 'hidden', name: $(this).attr('name'), value: $(this).attr('value')}
                ).appendTo($(this).closest('form'));
            }
        });
    },

    trackRadioForms: function () {
        var self = this,
            $form = $(self.radioFormClass).closest('form');

        // submitting GA tracked radio groups is intercepted[1] until the GA event
        // has been sent, by sending target to make a callback[2]
        $form.on('submit', function (e) {
            var eventDataArray,
                options;

            e.preventDefault(); // [1]

            eventDataArray = self.getRadioChoiceData($form);

            if (eventDataArray.length) {
                // there could be multiple radios that are checked and need a GA event firing,
                // but we only want to submit the form after sending the last one
                eventDataArray.forEach(function (eventData, n) {
                    if (n === eventDataArray.length - 1) {
                        options = {
                            actionType: 'form',
                            actionValue: $form // [2]
                        };
                    }

                    self.sendAnalyticsEvent(eventData, options);
                });
            } else {
                $form.unbind('submit').trigger('submit');
            }
        });
    },

    trackCheckboxes: function () {
        var self = this,
            $form = $(self.checkboxClass).closest('form');

        // submitting forms containing a GA tracked checkbox is intercepted[1]
        // until the GA event has been send, by sending target to make a
        // callback[2], unless no GA checkboxes in the form are checked, in which
        // case unbind and submit the form directly[3]
        $form.on('submit', function (e) {
            var eventDataArray,
                options;

            e.preventDefault(); // [1]

            eventDataArray = self.getCheckboxFormData($form, self);

            if (eventDataArray.length) {
                // there could be multiple GA checkboxes that are checked and need a
                // GA event firing, but we only want to submit the form after sending
                // the last one
                eventDataArray.forEach(function (eventData, n) {
                    if (n === eventDataArray.length - 1) {
                        options = {
                            actionType: 'form',
                            actionValue: $form // [2]
                        };
                    }

                    self.sendAnalyticsEvent(eventData, options);
                });
            } else {
                $form.unbind('submit').trigger('submit'); // [3]
            }
        });
    },

    trackLinks: function () {
        var self = this,
            $links = $(self.linkClass);

        // following GA tracked links is intercepted[1] until the GA event has
        // been sent, by sending target to make a callback[2]
        $links.on('click', function (e) {
            var $link = $(e.target),
                eventData,
                options;

            e.preventDefault(); // [1]

            eventData = self.getLinkData($link);
            options = {
                actionType: 'link',
                actionValue: $link // [2]
            };

            self.sendAnalyticsEvent(eventData, options);
        });
    },

    trackRevealingLinks: function() {
        var self = this,
            $links = $(self.revealingLinkClass);

        $links.on('click', function() {
            var $link = $(this),
                eventData,
                options;

            eventData = self.getLinkData($link);
            options = {
                actionType: 'revealing_link',
                actionValue: $link
            };

            // Only track when opening the details, not on close
            if ($link.closest('details:not([open])').length && eventData.eventCategory) {
                self.sendAnalyticsEvent(eventData, options);
            }
        });
    },

    trackClickActions: function() {
        var self = this,
            $elements = $(self.clickActionClass);

        $elements.on('click', function() {
            var $el = $(this),
                eventData;

            eventData = {
                eventCategory: $el.data('ga-category'),
                eventAction: $el.data('ga-action'),
                eventLabel: $el.data('ga-label')
            };

            self.sendAnalyticsEvent(eventData, {});
        });
    },

    trackExternalLinks: function() {
        $("a[rel^=external]").on('click', function(e) {
            var url = $(this).attr('href');

            window.open(url, '_blank');
            ga('send', 'event', 'outbound', 'click', url, {});

            e.preventDefault();
        });
    },

    trackSubmitForms: function () {
        var self = this,
            $form = $(self.submitFormClass);

        // submitting GA tracked forms is intercepted[1] until the GA event has
        // been sent, by sending target to make a callback[2]
        $form.on('submit', function (e) {
            var eventData,
                options;

            e.preventDefault(); // [1]

            eventData = self.getFormData($form);
            options = {
                actionType: 'form',
                actionValue: $form // [2]
            };

            self.sendAnalyticsEvent(eventData, options);
        });
    },

    getLinkData: function ($link) {
        var eventData;

        eventData = {
            eventCategory: $link.data('ga-category'),
            eventAction: 'select_link',
            eventLabel: $link.data('ga-label')
        };

        return eventData;
    },

    getRadioChoiceData: function ($form) {
        var $selectedRadios = $form.find('input[type="radio"]:checked'),
            eventDataArray = [];

        $selectedRadios.each(function (n, radio) {
            var $radio = $(radio),
                eventData;

            eventData = {
                hitType: 'event',
                eventCategory: $radio.attr('name'),
                eventAction: 'choose',
                eventLabel: $radio.val()
            };

            eventDataArray.push(eventData);
        });

        return eventDataArray;
    },

    getCheckboxFormData: function ($form, self) {
        var checkedCheckboxes = $form.find('input[type="checkbox"]:checked'),
            eventDataArray = [];

        checkedCheckboxes.each(function (n, checkbox) {
            var $checkbox = $(checkbox),
                eventData;

            eventData = {
                hitType: 'event',
                eventCategory: self.normaliseCheckboxAttribute($checkbox.attr('name')),
                eventAction: 'checkbox',
                eventLabel: $checkbox.data('ga-label') || $checkbox.val()
            };

            eventDataArray.push(eventData);
        });

        return eventDataArray;
    },

    getFormData: function ($form) {
        var category = $form.data('ga-category'),
            label = $form.data('ga-label'),
            eventData;

        eventData = {
            eventCategory: category,
            eventAction: 'submit_form',
            eventLabel: label
        };

        return eventData;
    },

    sendAnalyticsEvent: function (eventData, opts) {
        var self = this,
            opts = opts || {};

        //console.log(eventData);

        ga('send', 'event', eventData.eventCategory, eventData.eventAction, eventData.eventLabel, {
            hitCallback: self.createFunctionWithTimeout(function () {
                if (opts.actionType) {
                    if (opts.actionType === 'form') {
                        opts.actionValue.unbind('submit').trigger('submit');
                    } else if (opts.actionType === 'link') {
                        if (opts.actionValue.attr('target')) {
                            window.open(opts.actionValue.attr('href'), opts.actionValue.attr('target'));
                        } else {
                            document.location = opts.actionValue.attr('href');
                        }
                    }
                }
            })
        });
    },

    normaliseCheckboxAttribute: function(attrName) {
        // Some steps introduce 2 levels of check boxes, the 2nd level being a subgroup of options.
        // Normalise the attribute names so, analytics-wise, these become a single collection.
        //
        // Example:
        //      `steps_petition_orders_form[orders_collection]`
        // transformed to:
        //      `steps_petition_orders_form[orders]`
        //
        var normalisedAttr = attrName.replace('_collection]', ']');

        // Instead of sending a collection with all the selected options as the label, we send one event
        // per selected checkbox, which makes it easier to count and extract metrics for dashboards.
        // Removes the collection suffix `foobar[attr][]` leaving it as `foobar[attr]`
        //
        normalisedAttr = normalisedAttr.replace('[]', '');

        // Finally, if this is an exemptions checkbox, as there are 5 pages of exemptions with different
        // attribute names, we unify them to simplify aggregated metrics.
        //
        // Example:
        //      `steps_miam_exemptions_domestic_form[exemptions]`
        // transformed to:
        //      `steps_miam_exemptions_domestic_form[domestic]`
        //
        var regex = /^steps_miam_exemptions_([a-z]+)_form\[[\D]+\]$/;
        normalisedAttr = normalisedAttr.replace(regex, "steps_miam_exemptions_$1_form[$1]");

        return normalisedAttr;
    },

    createFunctionWithTimeout: function (callback, opt_timeout) {
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/sending-hits
        var called = false;

        function fn() {
            if (!called) {
                called = true;
                callback();
            }
        }

        setTimeout(fn, opt_timeout || 1000);
        return fn;
    }
};
