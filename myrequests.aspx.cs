using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyRequests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Checking whether user has logged in or not , if the user has not logged in or the session has expired,
        //user must relogin so the user is redirected automatically
        if (Session["Userid"] == null)
        {
            Response.Redirect("~/");
        }

    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string commandName = e.CommandName;
        if (commandName == "Pay")
        {
            string id = e.CommandArgument.ToString();
            Response.Redirect("~/TransactionForm?id=" + id);
        }
        else if (commandName == "Close")
        {
            string id = e.CommandArgument.ToString();
            Response.Redirect("~/review?id=" + id);
        }    
        //DataList1.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

    }

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}