using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
	public Helper()
	{
		
	}
    public static void addToUserTable(CustomUser user)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string insertCommand = "INSERT INTO Users (FirstName, LastName, Address, Email, Phone, Hash_Id) VALUES('" + user.FirstName + "','" + user.LastName + "','" + user.Address + "','" + user.Email + "','"+user.Phone+"','"+user.Hash_Id+"')";
        con.Open();
        SqlCommand cmd = new SqlCommand(insertCommand, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public static int getCustomUserId(String hash)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RidersConnectionConnectionString"].ConnectionString);
        string selectstatement = "SELECT Id FROM Users WHERE Hash_Id = '" + hash + "'";
        con.Open();
        //will pull all rides, filter handled by client
        SqlCommand selectcommand = new SqlCommand(selectstatement, con);
        SqlDataReader reader = selectcommand.ExecuteReader();
        reader.Read();
        con.Close();
        try
        {
            return int.Parse(reader["Id"].ToString());
        }
        catch
        {
            return -1;
        }
    }
}