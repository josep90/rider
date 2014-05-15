using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using rider;
using System.Data.SqlClient;
using System.Configuration;

public partial class Account_Register : Page
{
    protected void CreateUser_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string insertCommand = "INSERT INTO Users (FirstName, LastName, Address, Phone, Email, Username, Password) VALUES('" +FirstName.Text + "','" + LastName.Text + "','" + Address.Text + "','" + Phone.Text + "','" + Email.Text + "','" + UserName.Text + "', '"+ Password.Text +"')";
        con.Open();
        SqlCommand cmd = new SqlCommand(insertCommand, con);
        cmd.ExecuteNonQuery();
        
        string selectstatement = "SELECT Id, Username FROM Users WHERE Username = '" + UserName.Text + "' AND Password = '" + Password.Text + "'";
        SqlCommand selectcommand = new SqlCommand(selectstatement, con);
        SqlDataReader reader = selectcommand.ExecuteReader();
        string value = "-1";
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                value = reader["Id"].ToString();
                Session["Username"] = reader["Username"].ToString();
            }
            Session["UserId"] = value;
            Session["Userid"] = value;
        }

        con.Close();
        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        /*var manager = new UserManager();
        var user = new ApplicationUser() { 
            UserName = UserName.Text};
        IdentityResult result = manager.Create(user, Password.Text);
        if (result.Succeeded)
        {
            IdentityHelper.SignIn(manager, user, isPersistent: false);
            var customUser = new CustomUser
            {
                FirstName = FirstName.Text,
                LastName = LastName.Text,
                Email = Email.Text,
                Address = Address.Text,
                Hash_Id = user.UserName,
                Phone = Phone.Text
            };
            Helper.addToUserTable(customUser);
            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        }
        else
        {
            ErrorMessage.Text = result.Errors.FirstOrDefault();
        }*/
    }
}