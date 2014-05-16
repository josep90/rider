using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            //this.Master.PageH1Text = Session["FirstName"].ToString();
            if (!IsPostBack)
            {
                string id = Request.QueryString["Id"];
                txtOfferLockId.Value = id;
                txtAmount.Value = (id == null ? "0.00" : calculateAmount(id));
                AmountLabel.Text = string.Format("{0:c}", Convert.ToDouble(txtAmount.Value));
            }   
        }
        else
        {
            Response.Redirect("~/");
        }              
    }

    private string calculateAmount(String id)
    {
        string amount = "";
        con.Open();
        string accept = "select (offer_lock.trip_distance * offers.rate) amount from offers, offer_lock where offers.id = offer_lock.offer_id and offer_lock.id = " + id;
        SqlCommand cmd = new SqlCommand(accept, con);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            amount = dr.GetValue(0).ToString();           
        }
        con.Close();
        return amount;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string offerlockId = txtOfferLockId.Value;
            string amount = txtAmount.Value;

            con.Open();

            SqlCommand insert = new SqlCommand("insert into [dbo].[Transaction]([Offer_Lock_Id],[User_Id],[Confirmation_Code], [Amount]) values(@OfferLockId, @UserId, @ConfirmationCode, @Amount)", con);
            insert.Parameters.AddWithValue("@OfferLockId", offerlockId);
            insert.Parameters.AddWithValue("@UserId", Session["Userid"]);
            insert.Parameters.AddWithValue("@ConfirmationCode", GeneratePassword());
            insert.Parameters.AddWithValue("@Amount" ,amount);
            insert.ExecuteNonQuery();
          
            string accept = "update dbo.Offer_Lock set status = 3 where id = " + offerlockId;
            SqlCommand cmd = new SqlCommand(accept, con);
            cmd.ExecuteNonQuery();

            string reject = " update dbo.Offer_Lock set status = 2 " + 
                            " where offer_id in (select offer_id from dbo.Offer_Lock where id = " + offerlockId  + " ) "
                            + "and id <> " + offerlockId;
            cmd = new SqlCommand(reject, con);
            cmd.ExecuteNonQuery();


            con.Close();
            Response.Redirect("~/myrequests.aspx");
        }

    }

    private string GeneratePassword()
    {
        string strPwdchar = "abcdefghijklmnopqrstuvwxyz0123456789#+@&$ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        string strPwd = "";
        Random rnd = new Random();
        for (int i = 0; i <= 7; i++)
        {
            int iRandom = rnd.Next(0, strPwdchar.Length - 1);
            strPwd += strPwdchar.Substring(iRandom, 1);
        }
        return strPwd;
    }
}