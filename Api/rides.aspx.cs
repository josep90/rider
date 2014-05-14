using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Api_rides : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["find"] != null && Request.QueryString["find"] == "rides")
        {
            GetAvailableRides();
        }else if(Request.QueryString["set"]!=null && Request.QueryString["set"]== "offer"){
            OfferRide();
        }
        Response.End();
    }
    private void Out(Data obj, int status)
    {
        var json = new JavaScriptSerializer().Serialize(obj);
        Response.Clear();
        Response.ContentType = "application/json; charset=utf-8";
        Response.StatusCode = 400;
        Response.Write(json);
    }
    private void GetAvailableRides()
    {
        String registeredCondition = (Session["UserId"] != null) ? "AND o.User_Id != '" + Session["UserId"].ToString() + "'" : "";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string selectstatement = "SELECT o.*, u.Firstname AS Firstname FROM Offers AS o, Users as u WHERE o.status = 0 AND o.User_Id = u.Id " + registeredCondition;
        con.Open();
        //will pull all rides, filter handled by client
        SqlCommand selectcommand = new SqlCommand(selectstatement, con);
        SqlDataReader reader = selectcommand.ExecuteReader();
        Data data = new Data();
        while (reader.Read())
        {
            Ride ride = new Ride
            {
                Id = int.Parse(reader["Id"].ToString()),
                address = reader["Address"].ToString(),
                latitude = reader["Latitude"].ToString(),
                longitude = reader["Longitude"].ToString(),
                rate = reader["Rate"].ToString(),
                userId = reader["UserId"].ToString(),
                userName = reader["Firstname"].ToString()
            };

            data.rides.Add(ride);
        }
        con.Close();
        Out(data, 200);
    }
    private void RequestRide()
    {
       if (!User.Identity.IsAuthenticated)
            Out(new Data(), 400);
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        con.Open();
        String from = Request.QueryString["from"];
        String to = Request.QueryString["to"];
        String status = Request.QueryString["status"];
        String offerId = Request.QueryString["offer_id"];
        String userId = Session["UserId"].ToString();
        String tripDistance = Request.QueryString["trip_distance"];
        string insertStatement = "INSERT INTO Offer_Lock (From, To, Trip_Distance Status, Offer_Id, User_Id ) VALUES( '" + from + "', '" + to + "' ,'" + tripDistance +"' , 0 , "+ offerId + " ," + userId + " )";
        SqlCommand cmd = new SqlCommand(insertStatement, con);
        cmd.ExecuteNonQuery();
        con.Close();
        Out(new Data(), 200);
    }
    private Boolean OfferRide()
    {
        String latitude = Request.QueryString["latitude"];
        String longitude = Request.QueryString["longitude"];
        String address = Request.QueryString["address"];
        decimal rate = Decimal.Parse(Request.QueryString["rate"]);
        int status = int.Parse(Request.QueryString["status"]);
        int capacity = int.Parse(Request.QueryString["capacity"]);
        float maxDistance = float.Parse(Request.QueryString["max_distance"]);
        //user id
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string insertCommand = "INSERT INTO offers (Latitude, Longitude, Address, Rate, Status, Capacity, MaxDistance, User_Id) VALUES('" + latitude + "','" + longitude + "','" + address + "','" + rate + "','" + status + "','" + capacity + "','" + maxDistance + "','" + Session["UserId"].ToString()+ "')";
        con.Open();
        SqlCommand cmd = new SqlCommand(insertCommand, con);
        cmd.ExecuteNonQuery();
        con.Close();
        return false;
    }
}
public class Data
{
    public List<Ride> rides { get; set; }
    public Data()
    {
        rides = new List<Ride>();
    }
}