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
        else if (Request.QueryString["request"] != null && Request.QueryString["request"] == "ride")
        {
            RequestRide();
        }
        else
        {
            Out(new Data { message = Session["UserId"].ToString() }, 200);
        }
        Response.End();
    }
    private void Out(Data obj, int status)
    {
        var json = new JavaScriptSerializer().Serialize(obj);
        Response.Clear();
        Response.ContentType = "application/json; charset=utf-8";
        Response.StatusCode = status;
        Response.Write(json);
        Response.End();
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
                max_distance = reader["MaxDistance"].ToString(),
                max_capacity = reader["Capacity"].ToString(),
                user_id = reader["User_Id"].ToString(),
                username = reader["Firstname"].ToString()
            };

            data.rides.Add(ride);
        }
        con.Close();
        Out(data, 200);
    }
    private void RequestRide()
    {
       if (!User.Identity.IsAuthenticated)
           Out(new Data { message = "You must be logged in to requets a ride!"}, 400);
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        con.Open();
        String from = Request.QueryString["from"];
        String to = Request.QueryString["to"];
        String offerId = Request.QueryString["offer_id"];
        String userId = Session["UserId"].ToString();
        String tripDistance = Request.QueryString["trip_distance"];
        string insertStatement = "INSERT INTO Offer_Lock (From, To, Trip_Distance Status, Offer_Id, User_Id ) VALUES( '" + from + "', '" + to + "' ,'" + tripDistance +"' , 0 , "+ offerId + " ," + userId + " )";
        SqlCommand cmd = new SqlCommand(insertStatement, con);
        cmd.ExecuteNonQuery();
        con.Close();
        Out(new Data { message = "Your ride has been requested! Your rider will be notified soon. Thanks!"}, 200);
    }
    private void OfferRide()
    {
        if (!User.Identity.IsAuthenticated)
        {
            Out(new Data { message = "You must login to offer a ride." }, 400);
            
        }
        String latitude = Request.QueryString["latitude"];
        String longitude = Request.QueryString["longitude"];
        String address = Request.QueryString["address"];
        decimal rate = Decimal.Parse(Request.QueryString["rate"]);
        //default is available
        int status = 0;
        int capacity = int.Parse(Request.QueryString["capacity"]);
        float maxDistance = float.Parse(Request.QueryString["max_distance"]);
        //user id
        String userId = (Session["UserId"] != null) ? (Session["UserId"]).ToString() : "-1";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string insertCommand = "INSERT INTO Offers (Latitude, Longitude, Address, Rate, Status, Capacity, MaxDistance, User_Id) VALUES('" + latitude + "','" + longitude + "','" + address + "','" + rate + "','" + status + "','" + capacity + "','" + maxDistance + "','" + userId+ "')";
        con.Open();
        SqlCommand cmd = new SqlCommand(insertCommand, con);
        cmd.ExecuteNonQuery();
        con.Close();
        Out(new Data { message = "Success!"}, 200);
    }
}
public class Data
{
    public List<Ride> rides { get; set; }
    public String message { get; set; }
    public Data()
    {
        rides = new List<Ride>();
    }
}