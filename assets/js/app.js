/*
   @overview Starotel
   @file app.js
   @author ggordon
   @created 22.10.2015
   @description
   @dependencies
*/

(function ($, ko, window) {

    /**
     *  Starotel Namespace
     */
    var SNM = SNM || {};
    /**
      *
      *
      */
    SNM.popup = function (props) {
        props = props || {};
        $.UIPopup({
            selector: "#main",
            id: "starotel-popup",
            title: props.title || "Message",
            message: props.message || "Thank you for using Starotel Mobile Check In",
            cancelButton: props.cancelMessage || 'Close',
            continueButton: props.continueMessage || 'Ok',
            callback: props.callback || function () {

            }
        });
    };
    SNM.goBack = function () { };
    SNM.Helpers = {};
    SNM.Helpers.Validation = {};
    SNM.Helpers.Validation.required = function (value, fieldName, customMessage) {
        var valid = !!value;
        if (valid && value.trim().length == 0)
            valid = false;
        if (!valid)
            return customMessage || (fieldName ? fieldName + ' is required' : 'All fields are required');
        else
            return valid;
    }
    SNM.pages = ["welcome", "reservation", "contact", "credit"];
    SNM.goToPage = function (selector, back) {
        if (!selector || selector.trim().length == 0)
            return;
        if (selector.match(/^[\.#]/g) == null)
            selector = '#' + selector;
        //$('article.current').removeClass('current');
        //chrome engine hack
        var tempHistory = SNM.history,
            tempLen = SNM.history.length;
        //$.UIGoToArticle(selector);
        if (SNM.pages.indexOf(selector.substr(1)) == -1) selector = "#" + SNM.pages[0];

        $('article:not(article' + selector + '), nav').removeClass('current')
                     .removeClass('previous')
                     .addClass('next');
        $('article' + selector).addClass('current')
                                .removeClass('next').removeClass('previous')
                                .prev('nav').addClass('current')
                                .removeClass('next').removeClass('previous');


        SNM.history = tempLen == tempHistory.length ?
            tempHistory :
                                         (function (t) {
                                             t.pop(); return t;
                                         })(tempHistory);
        if (!back) {
            SNM.history.push(selector);

        }
        //$('article'+selector).addClass('current');
        $.UINavigationHistory = SNM.history || ($.UINavigationHistory || []).push(selector);
        $('.tabbar button').removeClass('selected');
        $('.tabbar button[class="' + selector.replace(/[\.#]/, '') + '"]').addClass('selected');
    };
    SNM.history = ['#welcome'];
    SNM.init = function () {

        //validation displays
        $('li.validation').hide();
        $('#checkInApp input').change(function () {
            $('li.validation span').each(function (i, el) {
                $(el).parent().hide();
            });
            $('li.validation span[style*="visibility: visible;"]').each(function (i, el) {
                $(el).parent().show();
            });
        })
        //registering handlers
        $('.datepicker').pickadate({
            format: 'mm/dd/yyyy',
            selectYears: true,
            selectMonths: true,
            min: new Date(),
            onOpen: function () {
                $('.picker__frame, .picker__holder').show();
            },
            onClose: function () {
                $('.picker__frame, .picker__holder').hide();
            }
        });

        $('.range-slider-1-5').each(function (i, el) {
            $(el).jRange({
                from: 1,
                to: 5,
                step: 1,
                scale: [1, 2, 3, 4, 5],
                format: '%s',
                width: (function () {
                    return (0.45 * $(window).width()) + '';
                })(),
                showLabels: true
            });
        });
        //$('selecto').selectize();
        $('.inline-radio').UISelectList({
            selected: 1,
            callback: $.noop
        });

        $(function () {
            var opts = {
                tabs: 4,
                imagePath: "./vendor/chui/images/icons/",
                icons: ["welcome", "reservation", "contact", "credit"],
                labels: ["Welcome", "Reservation", "Contact", "Credit"],
                selected: 0
            };
            $.UITabbar(opts);
        });
        $.UIGoBack = function () {

            SNM.history.pop();

            if (SNM.history.length == 0) {

                SNM.history.push('#welcome');

                SNM.goToPage('welcome');

            } else {

                SNM.goToPage(SNM.history[SNM.history.length - 1], true);

            }

            $.UINavigationHistory = SNM.history;


        };

        /*
                $('button.back').click(function (evt) {
                    //evt.preventDefault();
                   var prev = $(this).parent('nav').prev('article').attr('id') || "welcome";
        //          window.alert('going to page : '+prev);
                  SNM.goToPage(prev);
                    return false;
                    SNM.history.pop();
                    if(SNM.history.length==0){
                        SNM.history.push('#welcome');
                        SNM.goToPage('welcome');
                    }else{
                        SNM.goToPage(SNM.history[SNM.history.length-1],true);
                    }
                    $.UINavigationHistory = SNM.history;
                    return false;
                });
        */
        $('button.back').click(function () { $.UIGoBack(); return false; });//.html('&#10094;').css('font-size','2em');
        /*
        $('button.back').after('<button class="backo">&#10094;</button>').remove();
        $('button.backo').click(function(){
                   var prev = $(this).parent('nav').prev('article').attr('id') || "welcome";
                  SNM.goToPage(prev);
                  return false;
        }); */
        var tabCreatedInterval = setInterval(function () {
            if ($('.tabbar button').length != 0) {
                clearInterval(tabCreatedInterval);
                $('.tabbar button').click(function () {
                    var selector = $(this).children('label').html().toLowerCase();
                    SNM.history.push('#' + (selector == "Welcome" ? 'welcome' : selector));
                    $.UINavigationHistory = SNM.history;
                });
            }
        }, 300);
        $('body').removeClass('isNativeAndroidBrowser');
        $('article').on('swipeleft', function () {
            var next = $(this).next('nav').next('article').attr('id') || 'welcome';
            SNM.goToPage(next);
        }).on('swiperight', function () {
            var next = $(this).prev('nav').prev('article').attr('id') || 'welcome';
            SNM.goToPage(next);
        });
    };

    function ReservationVM(props) {
        props = props || {};
        var _self = this;
        _self.checkInDate = ko.observable(props.checkInDate || "");
        _self.checkOutDate = ko.observable(props.checkOutDate || "");
        _self._noOfGuests = 1;
        _self.noOfGuestsChange = function () {
            _self.noOfGuests($("#txtNoOfGuests").val());
        }
        _self.noOfGuests = ko.pureComputed({
            read: function () {
                var val = $("#txtNoOfGuests").val();
                if (this._noOfGuests != val)
                    this._noOfGuests = val;
                console.log('read : '+val);
                return val;
            },
            write: function (value) {
                console.log('wrote : '+value);
                $("#txtNoOfGuests").val(this._noOfGuests = value);
            },
            owner: _self
        });
        _self.noOfRooms = ko.observable(props.noOfRooms || "1");
        _self.reset = function () {
            _self.checkInDate('');
            _self.checkOutDate('');
            _self.noOfGuests('1');
            _self.noOfRooms('1');
        };

        _self.html = function () {
            return '<p>Check In  : ' + _self.checkInDate() + '</p>\
                    <p>Check Out : ' + _self.checkOutDate() + '</p>\
                    <p>Guests  : ' + $("#txtNoOfGuests").val() + '</p>\
                    <p>Rooms  : ' + $("#txtNoOfRooms").val() + '</p>';
        };
        _self.isValid = function () {
            if (_self.checkInDate().trim().length == 0 || !_self.checkInDate().trim().match(/^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/g)) {
                return 'Please enter your check in date in the form MM/DD/YYYY';
            }
            if (_self.checkOutDate().trim().length == 0 || !_self.checkOutDate().trim().match(/^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$/g)) {
                return 'Please enter your check out date in the form MM/DD/YYYY';
            }
            if (new Date(_self.checkInDate()) > new Date(_self.checkOutDate())) {
                return 'Please choose a check in date earlier than your check out date';
            }
            return true;
        };
    }

    function ContactInfoVM(props) {
        props = props || {};
        var _self = this;

        _self.lastName = ko.observable(props.lastName || "");
        _self.firstName = ko.observable(props.firstName || "");
        _self.streetNumber = ko.observable(props.streetNumber || "");
        _self.city = ko.observable(props.city || "");
        _self.state = ko.observable(props.state || "");
        _self.country = ko.observable(props.country || "");
        _self.postalCode = ko.observable(props.postalCode || "");
        _self.phoneNumber = ko.observable(props.phoneNumber || "");
        _self.email = ko.observable(props.email || "");
        _self.reset = function () {
            var fds = [
                    { field: 'lastName', readableName: 'Last Name' },
                    { field: 'firstName', readableName: 'First Name' },
                    { field: 'streetNumber', readableName: 'Street' },
                    { field: 'city', readableName: 'City' },
                    { field: 'state', readableName: 'Province / State' },
                    { field: 'country', readableName: 'Country' },
                    { field: 'postalCode', readableName: 'Postal Code' },
                    { field: 'phoneNumber', readableName: 'Phone Number' },
                    { field: 'email', readableName: 'Email' },
            ];
            for (var i = 0; i < fds.length; i++)
                _self[fds[i].field]('');
        };

        _self.html = ko.computed(function () {
            return '<p>Name  : ' + _self.firstName() + ' ' + _self.lastName() + '</p>\
                    <p>Address :</p>\
                    <p>' + _self.streetNumber() + ', ' + _self.city() + ', ' + _self.state() + ', ' + _self.country() + ', ' + _self.postalCode() + '</p>\
                    <p>Phone : ' + _self.phoneNumber() + '</p>\
                    <p>Email  : ' + _self.email() + '</p>';
        }, _self);

        _self.isValid = ko.computed(function () {
            var fields = [
                    { field: 'lastName', readableName: 'Last Name' },
                    { field: 'firstName', readableName: 'First Name' },
                    { field: 'streetNumber', readableName: 'Street' },
                    { field: 'city', readableName: 'City' },
                    { field: 'state', readableName: 'Province / State' },
                    { field: 'country', readableName: 'Country' },
                    { field: 'postalCode', readableName: 'Postal Code' },
                    { field: 'phoneNumber', readableName: 'Phone Number' },
                    { field: 'email', readableName: 'Email' },
            ],
                valid = true;
            for (var i = 0; i < fields.length; i++) {
                valid = SNM.Helpers.Validation.required(_self[fields[i].field](), fields[i].readableName);
                if (valid != true)
                    return valid;
            }

            var country = _self.country().trim(),
                postalCode = _self.postalCode().trim(),
                phoneNumber = _self.phoneNumber().trim();
            //valid canada postal code + phone
            if (country == "CAN") {
                if (!postalCode.match(/^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$/))
                    return "Please enter a valid Canadian postal code. Eg. T2D 1D3";
                if (!phoneNumber.match(/\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*/))
                    return "Please enter a valid Canadian Phone Number Eg. 8154553212";
            }
                //valid us postal code + phone
            else if (country == "USA") {
                if (!postalCode.match(/^\d{5}(-\d{4})?$/))
                    return "Please enter a valid US postal code. Eg. 92103";
                if (!phoneNumber.match(/\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*/))
                    return "Please enter a valid US Phone Number Eg. 8154553212";
            }
            return true;
        }, _self);
    }

    function CreditInfoVM(props) {
        props = props || {};
        var _self = this;

        _self.cardType = ko.observable(props.cardType || "Visa");
        _self.checkCardType = function (value,id) {
            value = value || $("#" + id).attr('value');
            _self.cardType(value);
            $("input[name='rdbCardType']").prop('checked', false);
            $("#" + id).prop('checked', true);
            $("#txtCardType").val(value);
        }
        _self.nameOnCard = ko.observable(props.nameOnCard || "");
        _self.cardNumber = ko.observable(props.cardNumber || "");
        _self.expirationDate = ko.observable(props.expirationDate || "");
        _self.reset = function () {
            _self.nameOnCard('');
            _self.cardNumber('');
            _self.expirationDate('');
        }
        _self.html = ko.computed(function () { return ""; }, _self);
        _self.isValid = ko.computed(function () {
            var valid = SNM.Helpers.Validation.required(_self.nameOnCard(), 'Name On Card');
            if (valid != true)
                return valid;

            var cardType = _self.cardType().trim(),
                cardNumber = _self.cardNumber().trim(),
                expires = _self.expirationDate().trim();
            if (!expires.match(/^[0-9]{2}\/20[0-9]{2}$/)) {
                return "It seems your card has been expired or you have entered an incorrect expiration date. Please enter an expiration date between 2014 and 2031";
            } else {
                var last2 = parseInt(expires.substr(5));
                if (last2 < 15 || last2 > 30)
                    return "It seems your card has been expired or you have entered an incorrect expiration date. Please enter an expiration date between 2014 and 2031";
                //check if expires this month
                if (parseInt(expires.substr(0, 2)) < new Date().getMonth() + 1)
                    return 'It seems your card has expired';
            }
            if (!cardNumber.match(/^[0-9]+$/))
                return 'Please enter numbers only for your card number';
            if (cardType == 'Visa') {
                if (cardNumber.length != 16 || cardNumber.substr(0, 1) != '4')
                    return 'Please enter a valid Visa Card Number';
            }
            if (cardType == 'Master Card') {
                if (cardNumber.length != 16 || !cardNumber.match(/^5[1-5][0-9]+$/))
                    return 'Please enter a valid Master Card Number';
            }
            if (cardType == 'American Express') {
                if (cardNumber.length != 15 || !cardNumber.match(/^3(4|7)[0-9]+$/))
                    return 'Please enter a valid American Express Card Number';
            }
            return true;
        }, _self);
    }

    function CheckInViewModel(props) {
        props = props || {};
        var _self = this;

        _self.fullName = ko.observable(props.fullName || "");
        /**
         *  Section View Models
         */
        _self.reservationSection = new ReservationVM();
        _self.contactSection = new ContactInfoVM();
        _self.creditCardSection = new CreditInfoVM();

        /**
         *  Section Actions
         */
        _self.goToReservation = function () {
            SNM.goToPage("reservation");
        };
        _self.goToContactInfo = function () {
            var valid = _self.reservationSection.isValid();
            if (valid == true) {
                //go to next section
                SNM.goToPage("contact");
            } else {
                SNM.popup({
                    title: 'Something is missing',
                    message: valid
                });
            }
        }

        _self.goToCreditInfo = function () {
            var valid = _self.contactSection.isValid();
            if (valid == true) {
                //go to next section
                SNM.goToPage("credit");
            } else {
                SNM.popup({
                    title: 'Something is missing',
                    message: valid
                });
            }
        }

        _self.goToConfirmInfo = function () {
            var valid = _self.reservationSection.isValid();
            if (valid != true) {
                SNM.goToPage("reservation");
                SNM.popup({
                    title: 'Something is missing',
                    message: valid
                });
                return;
            }
            valid = _self.contactSection.isValid();
            if (valid != true) {
                SNM.goToPage("contact");
                SNM.popup({
                    title: 'Something is missing',
                    message: valid
                });
                return;
            }
            valid = _self.creditCardSection.isValid();
            if (valid != true) {
                SNM.goToPage("credit");
                SNM.popup({
                    title: 'Something is missing',
                    message: valid
                });
                return;
            }

            if (valid == true) {
                if ((Page_IsValid != undefined && !Page_IsValid) || $('li.validation span[style*="visible"]').length > 0) {
                    var page = $($('li.validation span[style*="visible"]').get(0)).parents('article').attr('id');
                    SNM.goToPage(page);
                    SNM.popup({
                        title: 'Something is missing',
                        message: 'Please correct the errors on this page before continuing'
                    });
                    return;
                }
                SNM.popup({
                    title: 'Booking Details',
                    message: _self.reservationSection.html() + _self.contactSection.html() + _self.creditCardSection.html(),
                    callback: _self.submitInfo
                });//go to next section
            }
        }

        _self.submitInfo = function () {

            console.log('Form Submitted Successfully');
            //$.post('Default.aspx',$('form').serialize());
            SNM.popup({
                title: 'Booking Successful',
                message: 'Your booking was successful',
                callback: function () {

                }
            });
            setTimeout(function () {
                $('#btnFinalSubmit').trigger('click');
            }, 800);           
            
            // SNM.goToPage("welcome");
            //_self.reset();
            //ajax to same page
        }

        _self.reset = function () {
            _self.reservationSection.reset();
            _self.contactSection.reset()
            _self.creditCardSection.reset()
        };

    }


    $(document).ready(function () {
        SNM.checkInVM = new CheckInViewModel();
        window.SNM = SNM;
        ko.applyBindings(SNM.checkInVM, $('#checkInApp').get(0));
        SNM.init();
    });
})(jQuery, ko, window || {});