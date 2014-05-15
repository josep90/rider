using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Providers.Entities;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
    private static string tempId = "-1";
	public Helper()
	{
		
	}
    public static void addToUserTable(CustomUser user)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string insertCommand = "INSERT INTO Users (FirstName, LastName, Address, Phone, Email, Hash_Id) VALUES('" + user.FirstName + "','" + user.LastName + "','" + user.Address + "','" + user.Phone + "','" + user.Email + "','" + user.Hash_Id + "')";
        con.Open();
        SqlCommand cmd = new SqlCommand(insertCommand, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public static void startSession()
    {

    }
    public static string getCustomUserId(string hash)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string selectstatement = "SELECT Id FROM Users WHERE Username = '" + hash + "' ";
        con.Open();
        SqlCommand selectcommand = new SqlCommand(selectstatement, con);
        SqlDataReader reader = selectcommand.ExecuteReader();
        string value = "-1";
        while(reader.Read()){
            value = reader["Id"].ToString();
        }
        con.Close();
        return value;
    }
    
}