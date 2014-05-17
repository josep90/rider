using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Review : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["Id"];
                txtOfferLockId.Value = id;
            }
        }
        else
        {
            Response.Redirect("~/");
        }   

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        con.Open();
        string offerId = "";
        string sql = "select offer_id from offer_lock where offer_lock.id = " + txtOfferLockId.Value;
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            offerId = dr.GetValue(0).ToString();           
        }

        sql = "INSERT INTO [dbo].[User_Reviews] ([Offer_Id], [Ratings], [Comments],[Reviewer_User_Id]) " +
            "VALUES(@OfferId, @Ratings, @Comments, @ReviewerUserId)" ;
        SqlCommand insert = new SqlCommand(sql, con);
        insert.Parameters.AddWithValue("@OfferId", offerId);
        insert.Parameters.AddWithValue("@Ratings", ddlRatings.SelectedValue);
        insert.Parameters.AddWithValue("@Comments", txtComments.Text);
        insert.Parameters.AddWithValue("@ReviewerUserId", Session["Userid"]);
        insert.ExecuteNonQuery();

        sql = "update dbo.Offer_Lock set status = 4 where id = " + txtOfferLockId.Value;
        cmd = new SqlCommand(sql, con);
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("~/messages");
    }
}