using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        Data obj = new Data();
        if (Request.QueryString["get"] != null && Request.QueryString["get"] == "locations")
        {
            obj = GetAvailableLocations((String)Request.QueryString["start_location"]);
        }
        else if (Request.QueryString["request"] != null)
        {
            //set records
            if (!setOffer(Request.QueryString["request"]))
            {
                Item item = new Item {max= 1 };
                obj.Items.Add(item);
            }
            else
            {
                Item item = new Item { max = 0 };
                obj.Items.Add(item);
            }


        }
        else if (Request.QueryString["offer"] != null)
        {
            String[] data = Request.QueryString["location"].Split(',');
            double latitude = Double.Parse(data[0]);
            double longitude = Double.Parse(data[1]);
            double rate = Double.Parse(Request.QueryString["rate"]);
            double passenterCount = Double.Parse(Request.QueryString["passengers"]);
            double distance = Double.Parse(Request.QueryString["distance"]);
            
            int userId = Convert.ToInt32(Session["Userid"].ToString());
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
            con.Open();
            string selectstatement = "INSERT INTO Offer_Information (UserID, Longitude, Latitude, Distance, StartDate, ExpiryDate, Passenger_Count, Type, Rate, OfferInformation, Address) VALUES(" + userId + ", " + longitude + ", "+ latitude+ ", "+distance+", 0, 0 , "+ passenterCount+ ", 0, "+rate+" , 0 , 0 )";
            SqlCommand selectcommand = new SqlCommand(selectstatement, con);
            selectcommand.ExecuteNonQuery();
            con.Close();

        }
        var json = new JavaScriptSerializer().Serialize(obj);
        Response.Clear();
        Response.ContentType = "application/json; charset=utf-8";
        Response.Write(json);
        Response.End();
    }
    private Boolean available()
    {
        return true;
    }
    private Boolean setOffer(String OfferId)
    {
        if (!User.Identity.IsAuthenticated)
            return false;
        int userId = Convert.ToInt32(Session["Userid"].ToString());
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        con.Open();
        string selectstatement = "INSERT INTO Offer_Lock (Offer_ID, Status, UserId) VALUES("+OfferId+", 0, "+userId+")";
        SqlCommand selectcommand = new SqlCommand(selectstatement, con);
        selectcommand.ExecuteNonQuery();
        con.Close();
        return true;
    }
    private Data getLocation(double [] bounds, double radius)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        con.Open();
        double latitudeMin = bounds[0];
        double latitudeMax = bounds[1];
        double longitudeMin = bounds[2];
        double longitudeMax = bounds[3];
        double meridianLongMin = bounds[4];
        double meridianLongMax = bounds[5];

        /*string selectstatement = "SELECT * FROM Offer_Information WHERE latitude > " + latitudeMin +
            " AND latitude < " + latitudeMax + " AND longitude > " + longitudeMin + " AND longitude < " + longitudeMax;*/
        string selectstatement = "SELECT offer.*, usertable.Firstname AS user1 FROM Offer_Information AS offer, User_Information AS usertable WHERE offer.UserID = usertable.User_ID AND offer.Distance <"+radius;
        SqlCommand selectcommand = new SqlCommand(selectstatement, con);
        SqlDataReader reader = selectcommand.ExecuteReader();
        Data data = new Data();
        while (reader.Read())
        {
            String id= reader["Offer_ID"].ToString();
            string user = reader["user1"].ToString();
            int max = int.Parse(reader["Passenger_Count"].ToString());
            double rate = Double.Parse(reader["rate"].ToString());
            double distance = Double.Parse("11.1");
            Item item = new Item { 
                id= id,
                user = user,
                max = max,
                rate = rate,
                distance = distance
            };
            data.Items.Add(item);
        }
        /*Item t = new Item
        {
            longitude = latitudeMin,
            latitude = latitudeMax,
            distance = longitudeMin,
            address = longitudeMax.ToString()
        };
        data.Items.Add(t);*/
        con.Close();
        return data;
    }
    private Data GetAvailableLocations(String startLocation)
    {
        String[] data = startLocation.Split(',');
        double latitude = Double.Parse(data[0]);
        double longitude = Double.Parse(data[1]);
        double radius = Double.Parse(Request.QueryString["radius"]);
        double[] bounds = GetBounds(latitude, longitude, radius);
        //get locations within bounds
        Data items = getLocation(bounds, radius);
        return items;

    }
    private double[] GetBounds(double latitude, double longitude, double radius)
    {
        double earthRadius = 6371;
        //miles to km
        radius = radius * 1.60934;
        latitude = DegreeToRadian(latitude);
        longitude = DegreeToRadian(longitude);
        double angularRadius = radius / earthRadius;
        //get max, min latitudes
        double latitudeMin = latitude - angularRadius;
        double latitudeMax = latitude + angularRadius;

        double latitudeTangent = Math.Asin(Math.Sin(latitude) / Math.Cos(angularRadius));
        double longitudeDelta = Math.Asin(Math.Sin(angularRadius) / Math.Cos(latitude));
        //get max, min longitudes
        double longitudeMin = longitude - longitudeDelta;
        double longitudeMax = longitude + longitudeDelta;

        //180th meridians
        double meridianLongMin = 0;
        double meridianLongMax = 0;
        /*double meridianLatMin = 0;
        double meridianLatMax = 0;*/
        if (latitudeMax > Math.PI / 2)
        {
            longitudeMin = -Math.PI;
            latitudeMax = Math.PI / 2;
            longitudeMax = Math.PI;
        }
        else if (latitudeMin < Math.PI / 2)
        {
            latitudeMin = -Math.PI / 2;
            longitudeMin = -Math.PI;
            longitudeMax = Math.PI;
        }
        else if (longitudeMin < -Math.PI)
        {
            longitudeMin = longitudeMin + (2 * Math.PI);
            longitudeMax = Math.PI;
            meridianLongMin = -Math.PI;
            meridianLongMax = longitudeMax;
        }
        else if (longitudeMax > Math.PI)
        {
            longitudeMax = Math.PI;
            meridianLongMin = -Math.PI;
            meridianLongMax = longitudeMax - 2 * Math.PI;
        }
        double[] data = new double[6];
        data[0] = RadianToDegree(latitudeMin);
        data[1] = RadianToDegree(latitudeMax);
        data[2] = RadianToDegree(longitudeMin);
        data[3] = RadianToDegree(longitudeMax);
        data[4] = RadianToDegree(meridianLongMin);
        data[5] = RadianToDegree(meridianLongMax);

        return data;
    }
    private double RadianToDegree(double angle)
    {
        return angle * (180.0 / Math.PI);
    }
    private double DegreeToRadian(double angle)
    {
        return angle * Math.PI / 180.0;
    }
}
public class Data
{
    public List<Item> Items { get; set; }
    public Data()
    {
        Items = new List<Item>();
    }
}
public class Item
{
    public String id { get; set; }
    public String user { get; set; }
    public int max { get; set; }
    public double rate { get; set; }
    public double distance { get; set; }
    public String address { get; set; }
    public double latitude { get; set; }
    public double longitude { get; set; }
}