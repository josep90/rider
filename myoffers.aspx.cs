using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        //Checking whether user has logged in or not , if the user has not logged in or the session has expired,
        //user must relogin so the user is redirected automatically
        if (Session["UserId"] != null)
        {
            //this.Master.PageH1Text = Session["FirstName"].ToString();
        }

        else
        {
            Response.Redirect("~/");
        }
        

    }
    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Accept_Click(object sender, EventArgs e)
    {
    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string commandName = e.CommandName;

        if (commandName == "Reject")
        {
            con.Open();
            string id = e.CommandArgument.ToString();
            string reject = "update dbo.Offer_Lock set status = 2  where id = " + id;
            SqlCommand cmd = new SqlCommand(reject, con);
            cmd.ExecuteNonQuery();
        }
        else if (commandName == "Accept")
        {
            con.Open();
            string id = e.CommandArgument.ToString();
            string accept = "update dbo.Offer_Lock set status = 1  where id = " + id;
            SqlCommand cmd = new SqlCommand(accept, con);
            cmd.ExecuteNonQuery();

            string reject = "update dbo.Offer_Lock set status = 2  where offer_id = " 
                            + ddlOfferID.SelectedValue
                            + "and id <> " + id;
            cmd = new SqlCommand(reject, con);
            cmd.ExecuteNonQuery();
        }
        
        DataList1.DataBind();
    }
}