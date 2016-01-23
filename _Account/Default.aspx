<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Starotel.Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="msapplication-tap-highlight" content="no">
    <title>Starotel</title>
    <link rel="stylesheet" href="./assets/css/chui-brown-theme-android.css">
    <link href="vendor/pickadate.js-3.5.6/lib/compressed/themes/default.css" rel="stylesheet" />
    <link href="./vendor/pickadate.js-3.5.6/lib/compressed/themes/default.date.css" rel="stylesheet" />
    <link href="vendor/jquery-range/jquery.range.css" rel="stylesheet" />
    <link href="vendor/selectize/selectize.default.css" rel="stylesheet" />
    <link rel="stylesheet" href="./assets/css/app.css">
</head>
<body>
    <form id="checkInApp" runat="server">
        
        <nav class="current">
            <h1>Welcome <span data-bind="text: fullName" class="full-name"></span></h1>
        </nav>
        <article id="welcome" class="current">
            <section>
                <div class="banner-image"></div>
                <h2 class="welcome-title">Welcome to Starotel Check In</h2>
                <button data-bind="click : goToReservation" class="flat">Check In</button>
            </section>
        </article>
        <nav class="next">
            <button class='back'>Back</button>
            <h1>Reservation</h1>
        </nav>
        <article id="reservation" class="next">
            <section>
                <h2 class="page-title">Reservation Information</h2>
                <ul data-bind="with : reservationSection"  class="list" ui-implements="form">
                    <li>
                        <asp:TextBox data-bind="value : checkInDate" CssClass="datepicker" ID="txtCheckInDate" runat="server" autocapitalize="words" placeholder="Check In Date" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="regExValCheckInDate" runat="server" ControlToValidate="txtCheckInDate" ErrorMessage="Please enter your check-in date in the form (MM/DD/YYYY)" ValidationExpression="^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : checkOutDate" CssClass="datepicker" ID="txtCheckOutDate" runat="server" autocapitalize="words" placeholder="Check Out Date" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="regExValCheckOutDate" runat="server" ControlToValidate="txtCheckInDate" ErrorMessage="Please enter your check out date in the form (MM/DD/YYYY)" ValidationExpression="^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$"></asp:RegularExpressionValidator>
                    </li>
                    <li class="comp">
                        <div>
                            <label for="noOfGuests">Number of Guests</label>
                        </div>
                        <aside>
                            <input  data-bind="value : noOfGuests" type="hidden" id="txtNoOfGuests" runat="server" class="range-slider-1-5" value="1" />
                        </aside>
                    </li>
                    <li class="comp">
                        <div>
                            <label for="noOfRooms">Number of Rooms</label>
                        </div>
                        <aside>
                            <input  data-bind="value : noOfRooms" type="hidden" id="txtNoOfRooms" runat="server" class="range-slider-1-5" value="1" />
                        </aside>
                    </li>
                </ul>
                <button data-bind="click : goToContactInfo" class="action">Next</button>
            </section>
        </article>
        <nav class="next">
            <button class='back'>Back</button>
            <h1>Contact</h1>
        </nav>
        <article id="contact" class="next">
            <section>
                <h2 class="page-title">Contact Information</h2>
                <ul  data-bind="with : contactSection" class="list" ui-implements="form">
                    <li>
                        <asp:TextBox  data-bind="value : firstName" ID="txtFirstName" runat="server" autocapitalize="words" placeholder="First Name" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="Please enter your first name using only letters" ValidationExpression="^[a-zA-Z ']+$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : lastName" ID="txtLastName" runat="server" autocapitalize="words" placeholder="Last Name" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Please enter your last name using only letters" ValidationExpression="^[a-zA-Z ']+$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : streetNumber" ID="txtStreet" runat="server" autocapitalize="words" placeholder="Street" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValStreetNumber" runat="server" ControlToValidate="txtStreet" ErrorMessage="Please enter the street name correctly" ValidationExpression="^[a-zA-Z '0-9 \-]+$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : city" ID="txtCity" runat="server" autocapitalize="words" placeholder="City" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValCity" runat="server" ControlToValidate="txtCity" ErrorMessage="please enter the city correctly" ValidationExpression="^[a-zA-Z ']+$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : state" ID="txtState" runat="server" autocapitalize="words" placeholder="Province/State" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValState" runat="server" ControlToValidate="txtState" ErrorMessage="Please enter your province/state correctly" ValidationExpression="^[a-zA-Z .']+$"></asp:RegularExpressionValidator>
                    </li>
                    <li class="comp">
                        <div>
                            <label for="ddlCountry">Country</label>
                        </div>
                        <aside>
                            <select  data-bind="value : country" id="ddlCountry" runat="server">
                                <option value="AFG">Afghanistan</option>
                                <option value="ALA">Åland Islands</option>
                                <option value="ALB">Albania</option>
                                <option value="DZA">Algeria</option>
                                <option value="ASM">American Samoa</option>
                                <option value="AND">Andorra</option>
                                <option value="AGO">Angola</option>
                                <option value="AIA">Anguilla</option>
                                <option value="ATA">Antarctica</option>
                                <option value="ATG">Antigua and Barbuda</option>
                                <option value="ARG">Argentina</option>
                                <option value="ARM">Armenia</option>
                                <option value="ABW">Aruba</option>
                                <option value="AUS">Australia</option>
                                <option value="AUT">Austria</option>
                                <option value="AZE">Azerbaijan</option>
                                <option value="BHS">Bahamas</option>
                                <option value="BHR">Bahrain</option>
                                <option value="BGD">Bangladesh</option>
                                <option value="BRB">Barbados</option>
                                <option value="BLR">Belarus</option>
                                <option value="BEL">Belgium</option>
                                <option value="BLZ">Belize</option>
                                <option value="BEN">Benin</option>
                                <option value="BMU">Bermuda</option>
                                <option value="BTN">Bhutan</option>
                                <option value="BOL">Bolivia, Plurinational State of</option>
                                <option value="BES">Bonaire, Sint Eustatius and Saba</option>
                                <option value="BIH">Bosnia and Herzegovina</option>
                                <option value="BWA">Botswana</option>
                                <option value="BVT">Bouvet Island</option>
                                <option value="BRA">Brazil</option>
                                <option value="IOT">British Indian Ocean Territory</option>
                                <option value="BRN">Brunei Darussalam</option>
                                <option value="BGR">Bulgaria</option>
                                <option value="BFA">Burkina Faso</option>
                                <option value="BDI">Burundi</option>
                                <option value="KHM">Cambodia</option>
                                <option value="CMR">Cameroon</option>
                                <option value="CAN" selected="selected">Canada</option>
                                <option value="CPV">Cape Verde</option>
                                <option value="CYM">Cayman Islands</option>
                                <option value="CAF">Central African Republic</option>
                                <option value="TCD">Chad</option>
                                <option value="CHL">Chile</option>
                                <option value="CHN">China</option>
                                <option value="CXR">Christmas Island</option>
                                <option value="CCK">Cocos (Keeling) Islands</option>
                                <option value="COL">Colombia</option>
                                <option value="COM">Comoros</option>
                                <option value="COG">Congo</option>
                                <option value="COD">Congo, the Democratic Republic of the</option>
                                <option value="COK">Cook Islands</option>
                                <option value="CRI">Costa Rica</option>
                                <option value="CIV">Côte d'Ivoire</option>
                                <option value="HRV">Croatia</option>
                                <option value="CUB">Cuba</option>
                                <option value="CUW">Curaçao</option>
                                <option value="CYP">Cyprus</option>
                                <option value="CZE">Czech Republic</option>
                                <option value="DNK">Denmark</option>
                                <option value="DJI">Djibouti</option>
                                <option value="DMA">Dominica</option>
                                <option value="DOM">Dominican Republic</option>
                                <option value="ECU">Ecuador</option>
                                <option value="EGY">Egypt</option>
                                <option value="SLV">El Salvador</option>
                                <option value="GNQ">Equatorial Guinea</option>
                                <option value="ERI">Eritrea</option>
                                <option value="EST">Estonia</option>
                                <option value="ETH">Ethiopia</option>
                                <option value="FLK">Falkland Islands (Malvinas)</option>
                                <option value="FRO">Faroe Islands</option>
                                <option value="FJI">Fiji</option>
                                <option value="FIN">Finland</option>
                                <option value="FRA">France</option>
                                <option value="GUF">French Guiana</option>
                                <option value="PYF">French Polynesia</option>
                                <option value="ATF">French Southern Territories</option>
                                <option value="GAB">Gabon</option>
                                <option value="GMB">Gambia</option>
                                <option value="GEO">Georgia</option>
                                <option value="DEU">Germany</option>
                                <option value="GHA">Ghana</option>
                                <option value="GIB">Gibraltar</option>
                                <option value="GRC">Greece</option>
                                <option value="GRL">Greenland</option>
                                <option value="GRD">Grenada</option>
                                <option value="GLP">Guadeloupe</option>
                                <option value="GUM">Guam</option>
                                <option value="GTM">Guatemala</option>
                                <option value="GGY">Guernsey</option>
                                <option value="GIN">Guinea</option>
                                <option value="GNB">Guinea-Bissau</option>
                                <option value="GUY">Guyana</option>
                                <option value="HTI">Haiti</option>
                                <option value="HMD">Heard Island and McDonald Islands</option>
                                <option value="VAT">Holy See (Vatican City State)</option>
                                <option value="HND">Honduras</option>
                                <option value="HKG">Hong Kong</option>
                                <option value="HUN">Hungary</option>
                                <option value="ISL">Iceland</option>
                                <option value="IND">India</option>
                                <option value="IDN">Indonesia</option>
                                <option value="IRN">Iran, Islamic Republic of</option>
                                <option value="IRQ">Iraq</option>
                                <option value="IRL">Ireland</option>
                                <option value="IMN">Isle of Man</option>
                                <option value="ISR">Israel</option>
                                <option value="ITA">Italy</option>
                                <option value="JAM">Jamaica</option>
                                <option value="JPN">Japan</option>
                                <option value="JEY">Jersey</option>
                                <option value="JOR">Jordan</option>
                                <option value="KAZ">Kazakhstan</option>
                                <option value="KEN">Kenya</option>
                                <option value="KIR">Kiribati</option>
                                <option value="PRK">Korea, Democratic People's Republic of</option>
                                <option value="KOR">Korea, Republic of</option>
                                <option value="KWT">Kuwait</option>
                                <option value="KGZ">Kyrgyzstan</option>
                                <option value="LAO">Lao People's Democratic Republic</option>
                                <option value="LVA">Latvia</option>
                                <option value="LBN">Lebanon</option>
                                <option value="LSO">Lesotho</option>
                                <option value="LBR">Liberia</option>
                                <option value="LBY">Libya</option>
                                <option value="LIE">Liechtenstein</option>
                                <option value="LTU">Lithuania</option>
                                <option value="LUX">Luxembourg</option>
                                <option value="MAC">Macao</option>
                                <option value="MKD">Macedonia, the former Yugoslav Republic of</option>
                                <option value="MDG">Madagascar</option>
                                <option value="MWI">Malawi</option>
                                <option value="MYS">Malaysia</option>
                                <option value="MDV">Maldives</option>
                                <option value="MLI">Mali</option>
                                <option value="MLT">Malta</option>
                                <option value="MHL">Marshall Islands</option>
                                <option value="MTQ">Martinique</option>
                                <option value="MRT">Mauritania</option>
                                <option value="MUS">Mauritius</option>
                                <option value="MYT">Mayotte</option>
                                <option value="MEX">Mexico</option>
                                <option value="FSM">Micronesia, Federated States of</option>
                                <option value="MDA">Moldova, Republic of</option>
                                <option value="MCO">Monaco</option>
                                <option value="MNG">Mongolia</option>
                                <option value="MNE">Montenegro</option>
                                <option value="MSR">Montserrat</option>
                                <option value="MAR">Morocco</option>
                                <option value="MOZ">Mozambique</option>
                                <option value="MMR">Myanmar</option>
                                <option value="NAM">Namibia</option>
                                <option value="NRU">Nauru</option>
                                <option value="NPL">Nepal</option>
                                <option value="NLD">Netherlands</option>
                                <option value="NCL">New Caledonia</option>
                                <option value="NZL">New Zealand</option>
                                <option value="NIC">Nicaragua</option>
                                <option value="NER">Niger</option>
                                <option value="NGA">Nigeria</option>
                                <option value="NIU">Niue</option>
                                <option value="NFK">Norfolk Island</option>
                                <option value="MNP">Northern Mariana Islands</option>
                                <option value="NOR">Norway</option>
                                <option value="OMN">Oman</option>
                                <option value="PAK">Pakistan</option>
                                <option value="PLW">Palau</option>
                                <option value="PSE">Palestinian Territory, Occupied</option>
                                <option value="PAN">Panama</option>
                                <option value="PNG">Papua New Guinea</option>
                                <option value="PRY">Paraguay</option>
                                <option value="PER">Peru</option>
                                <option value="PHL">Philippines</option>
                                <option value="PCN">Pitcairn</option>
                                <option value="POL">Poland</option>
                                <option value="PRT">Portugal</option>
                                <option value="PRI">Puerto Rico</option>
                                <option value="QAT">Qatar</option>
                                <option value="REU">Réunion</option>
                                <option value="ROU">Romania</option>
                                <option value="RUS">Russian Federation</option>
                                <option value="RWA">Rwanda</option>
                                <option value="BLM">Saint Barthélemy</option>
                                <option value="SHN">Saint Helena, Ascension and Tristan da Cunha</option>
                                <option value="KNA">Saint Kitts and Nevis</option>
                                <option value="LCA">Saint Lucia</option>
                                <option value="MAF">Saint Martin (French part)</option>
                                <option value="SPM">Saint Pierre and Miquelon</option>
                                <option value="VCT">Saint Vincent and the Grenadines</option>
                                <option value="WSM">Samoa</option>
                                <option value="SMR">San Marino</option>
                                <option value="STP">Sao Tome and Principe</option>
                                <option value="SAU">Saudi Arabia</option>
                                <option value="SEN">Senegal</option>
                                <option value="SRB">Serbia</option>
                                <option value="SYC">Seychelles</option>
                                <option value="SLE">Sierra Leone</option>
                                <option value="SGP">Singapore</option>
                                <option value="SXM">Sint Maarten (Dutch part)</option>
                                <option value="SVK">Slovakia</option>
                                <option value="SVN">Slovenia</option>
                                <option value="SLB">Solomon Islands</option>
                                <option value="SOM">Somalia</option>
                                <option value="ZAF">South Africa</option>
                                <option value="SGS">South Georgia and the South Sandwich Islands</option>
                                <option value="SSD">South Sudan</option>
                                <option value="ESP">Spain</option>
                                <option value="LKA">Sri Lanka</option>
                                <option value="SDN">Sudan</option>
                                <option value="SUR">Suriname</option>
                                <option value="SJM">Svalbard and Jan Mayen</option>
                                <option value="SWZ">Swaziland</option>
                                <option value="SWE">Sweden</option>
                                <option value="CHE">Switzerland</option>
                                <option value="SYR">Syrian Arab Republic</option>
                                <option value="TWN">Taiwan, Province of China</option>
                                <option value="TJK">Tajikistan</option>
                                <option value="TZA">Tanzania, United Republic of</option>
                                <option value="THA">Thailand</option>
                                <option value="TLS">Timor-Leste</option>
                                <option value="TGO">Togo</option>
                                <option value="TKL">Tokelau</option>
                                <option value="TON">Tonga</option>
                                <option value="TTO">Trinidad and Tobago</option>
                                <option value="TUN">Tunisia</option>
                                <option value="TUR">Turkey</option>
                                <option value="TKM">Turkmenistan</option>
                                <option value="TCA">Turks and Caicos Islands</option>
                                <option value="TUV">Tuvalu</option>
                                <option value="UGA">Uganda</option>
                                <option value="UKR">Ukraine</option>
                                <option value="ARE">United Arab Emirates</option>
                                <option value="GBR">United Kingdom</option>
                                <option value="USA">United States</option>
                                <option value="UMI">United States Minor Outlying Islands</option>
                                <option value="URY">Uruguay</option>
                                <option value="UZB">Uzbekistan</option>
                                <option value="VUT">Vanuatu</option>
                                <option value="VEN">Venezuela, Bolivarian Republic of</option>
                                <option value="VNM">Viet Nam</option>
                                <option value="VGB">Virgin Islands, British</option>
                                <option value="VIR">Virgin Islands, U.S.</option>
                                <option value="WLF">Wallis and Futuna</option>
                                <option value="ESH">Western Sahara</option>
                                <option value="YEM">Yemen</option>
                                <option value="ZMB">Zambia</option>
                                <option value="ZWE">Zimbabwe</option>
                            </select>
                        </aside>
                    </li>
                    <li>
                        <asp:TextBox   data-bind="value : postalCode"  ID="txtPostalCode" runat="server" autocapitalize="words" placeholder="Postal Code" ></asp:TextBox>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : phoneNumber"  ID="txtPhoneNumber" runat="server" autocapitalize="words" placeholder="Phone Number" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Please use only numbers for your phone number" ValidationExpression="^[0-9]{0,14}$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : email"  ID="txtEmail" runat="server" autocapitalize="words" placeholder="Email" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="rgExValEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please enter a valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </li>
                </ul>
                <button data-bind="click : goToCreditInfo" class="action">Next</button>
            </section>
        </article>
        <nav class="next">
            <button class='back'>Back</button>
            <h1>Credit</h1>

        </nav>
        <article id="credit" class="next">
            <section>
                <h2 class="page-title">Credit Information</h2>
                <ul  data-bind="with : creditCardSection" class="list" ui-implements="form">
                    <li>
                            <p>Credit Card</p>
                            <ul class="list select inline-radio">
                                
                                <li data-bind="click : function(){cardType('American Express')}" role="radio" class="">
                                    <h3>American Express</h3>
                                    <input data-bind="checked: cardType, checkedValue: 'American Express'" type="radio" id="rdbCardType3" name="rdbCardType" runat="server" value="American Express">
                                </li>
                                <li data-bind="click : function(){cardType('Visa')}" role="radio" class="">                                    
                                    <input data-bind="checked: cardType, checkedValue: 'Visa'"  type="radio" id="rdbCardType1" name="rdbCardType" runat="server" value="Visa">
                                    <h3>Visa</h3>
                                </li>
                                <li data-bind="click : function(){cardType('Master Card')}" role="radio" class="">
                                    <h3>MasterCard</h3>
                                    <input data-bind="checked: cardType, checkedValue: 'Master Card'" type="radio" id="RrdbCardType2" name="rdbCardType" runat="server" value="MasterCard">
                                </li>
                                
                            </ul>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : nameOnCard"  ID="txtNameOnCard" runat="server" autocapitalize="words" placeholder="Name on Credit Card" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="regExValNameOnCard" runat="server" ControlToValidate="txtNameOnCard" ErrorMessage="Please enter your full name with only letters please" ValidationExpression="[a-zA-Z ']+ *[a-zA-Z ']+"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : cardNumber"  ID="txtCardNumber" runat="server" autocapitalize="words" placeholder="Card Number" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="regExValCardNumber" runat="server" ControlToValidate="txtCardNumber" ErrorMessage="Please use only numbers for your card number" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
                    </li>
                    <li>
                        <asp:TextBox  data-bind="value : expirationDate"  ID="txtExpirationDate" CssClass="expirationDate" runat="server" autocapitalize="words" placeholder="Expiration Date (MM/YYYY)" ></asp:TextBox>
                    </li>
                    <li class="validation">
                        <asp:RegularExpressionValidator ID="regExValExpirationDate" runat="server" ControlToValidate="txtExpirationDate" ErrorMessage="Please enter your expiration date in the form (MM/YYYY)" ValidationExpression="^[0-9]{2}\/[0-9]{4}$"></asp:RegularExpressionValidator>
                    </li>
                </ul>
                <button data-bind="click : goToConfirmInfo" id="btnSubmit"  class="action" runat="server">Check in</button>
            </section>
        </article>
    </form>
    <script src="./vendor/jquery/2.1.4/jquery-2.1.4.min.js"></script>
    <script src="./vendor/chui/chui/chui-3.9.2.min.js"></script>
    <script src="./vendor/knockoutjs/knockout-3.3.0.js"></script>
    <script src="vendor/pickadate.js-3.5.6/lib/compressed/picker.js"></script>
    <script src="vendor/pickadate.js-3.5.6/lib/compressed/picker.date.js"></script>
    <script src="vendor/jquery-range/jquery.range-min.js"></script>
    <script src="vendor/selectize/selectize.js"></script>
    <!--[if lt IE 9]><script src="http://cdnjs.cloudflare.com/ajax/libs/es5-shim/2.0.8/es5-shim.min.js"></script><![endif]-->
    <script src="./assets/js/app.js"></script>
</body>
</html>
