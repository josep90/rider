using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);

    //int successstatus;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtSecurityAnswer.Visible = false;
        txtSecurityQuestion.Visible = false;
        txtTypeyourAnswer.Visible = false;
        SecurityQuestion.Visible = false;
        SecurityAnswer.Visible = false;
        Typeyouranswer.Visible = false;
        ChangePassword.Visible = false;
        txtNewPassword.Visible = false;
        lblNewPassword.Visible = false;
        btnChangePassword.Visible = false;

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)  // if validation was successful
        {
            string email = txtEmailAddress.Text;
            // string question = txtSecurityAnswer.Text;
            //  string answer = txtSecurityAnswer.Text;

            con.Open();
            // string email1 = "";
            string ques = "";
            string ans = "";


            string selectstatement = "SELECT Security_Question,Security_Answer FROM Users WHERE Email='" + email + "' ;";
            SqlCommand selectcommand = new SqlCommand(selectstatement, con);

            SqlDataReader reader = selectcommand.ExecuteReader();
            while (reader.Read())
            {
                ques = reader["Security_Question"].ToString();
                ans = reader["Security_Answer"].ToString();
            }


            if (ques == "")
            {

                Label1.Text = "This email address/ username does Not Exist";


            }
            else if (ques != "")
            {
               // txtSecurityAnswer.Visible = true;
                txtSecurityQuestion.Visible = true;
                txtTypeyourAnswer.Visible = true;
                SecurityQuestion.Visible = true;
               // SecurityAnswer.Visible = true;
                Typeyouranswer.Visible = true;
                txtSecurityQuestion.Text = ques;
                txtSecurityAnswer.Text = ans;
                btnSubmit.Visible = false;
                ChangePassword.Visible = true;
                con.Close();

               
                //  if (question == ques && answer == ans)
                //   {
                //   Response.Redirect("~/Changepassword.aspx");
                //  }

                //  }



            }
        }
    }
    protected void ChangePassword_Click(object sender, EventArgs e)
    {

         if (txtTypeyourAnswer.Text==txtSecurityAnswer.Text)
         {
             txtSecurityAnswer.Visible = false;
             txtSecurityQuestion.Visible = false;
             txtTypeyourAnswer.Visible = false;
             SecurityQuestion.Visible = false;
             SecurityAnswer.Visible = false;
             Typeyouranswer.Visible = false;
             ChangePassword.Visible = false;
             ChangePassword.Visible = false;  // this is the security question button

             txtNewPassword.Visible = true;
             lblNewPassword.Visible = true;
             btnChangePassword.Visible = true;
             
         }

         else 
         {
             Label1.Text = "Security Answer MisMatch. Please retype your Security Answer";
             txtSecurityAnswer.Visible = true;
             // txtSecurityQuestion.Visible = true;
             txtTypeyourAnswer.Visible = true;
             SecurityQuestion.Visible = true;
             // SecurityAnswer.Visible = true;
             Typeyouranswer.Visible = true;
             btnChangePassword.Visible = false;
             btnSubmit.Visible = false;
             ChangePassword.Visible = true;
             txtNewPassword.Visible = false;
             lblNewPassword.Visible = false;
         }


       
    }
    protected void btnChangePassword_Click(object sender, EventArgs e)
    {

        con.Open();
       

                string updatestatement = "UPDATE Users set Password='"+txtNewPassword.Text+"' WHERE Email='" + txtEmailAddress.Text + "';";
        SqlCommand updatecommand = new SqlCommand(updatestatement, con);
        updatecommand.ExecuteNonQuery();
        
        txtNewPassword.Visible = false;
        lblNewPassword.Visible = false;
        btnChangePassword.Visible = false;
        Label1.Text = "Password updated! Please click on Login and login back to your system";
        con.Close();
         

       

    }
}