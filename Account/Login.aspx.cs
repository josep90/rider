using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using rider;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;

public partial class Account_Login : Page
{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Session["UserId"] = null;
            }
            RegisterHyperLink.NavigateUrl = "Register";
            OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                /*var manager = new UserManager();
                ApplicationUser user = manager.Find(UserName.Text, Password.Text);*/
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
                string selectstatement = "SELECT Id, Username FROM Users WHERE Username = '" + UserName.Text + "' AND Password = '"+ Password.Text +"'";
                con.Open();
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
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                /*if (user != null)
                {
                    IdentityHelper.SignIn(manager, user, RememberMe.Checked);
                    string test = User.Identity.GetUserName();
                    Session["UserId"] = Helper.getCustomUserId(test).ToString();
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }*/
                else
                {
                    FailureText.Text = "Invalid username or password.";
                    ErrorMessage.Visible = true;
                }
            }
        }
}