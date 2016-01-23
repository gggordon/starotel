using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Starotel
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                File.AppendAllText(Server.MapPath("persons.txt"),"\r\n"+ txtCheckInDate.Text + "," + txtCheckOutDate.Text +
                                                                    "," + txtNoOfGuests.Value + "," + txtNoOfRooms.Value + "," +
                    txtFirstName.Text + "," + txtLastName.Text + "," + txtStreet.Text + "," + txtCity.Text + "," + txtState.Text + "," + ddlCountry.Value +
                    "," + txtPostalCode.Text + "," + txtPhoneNumber.Text + "," + txtEmail.Text + "," + rdbCardType1.Value + "," +
                    RrdbCardType2.Value + "," + rdbCardType3.Value + "," + txtNameOnCard.Text + "," + txtCardNumber.Text + "," + txtExpirationDate.Text);
            }

            

        }
    }
}