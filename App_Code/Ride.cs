using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Ride
{
    public int Id { get; set; }
    public String latitude { get; set; }
    public String longitude { get; set; }
    public String address { get; set; }
    public String rate { get; set; }
    public String user_id { get; set; }
    public String username { get; set; }
    public String max_distance { get; set; }
    public String max_capacity { get; set; }
	public Ride()
	{
	}
}