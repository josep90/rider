﻿using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using rider;

public partial class Account_Register : Page
{
    protected void CreateUser_Click(object sender, EventArgs e)
    {
        var manager = new UserManager();
        var user = new ApplicationUser() { 
            UserName = UserName.Text};
        IdentityResult result = manager.Create(user, Password.Text);
        if (result.Succeeded)
        {
            IdentityHelper.SignIn(manager, user, isPersistent: false);
            var customUser = new CustomUser
            {
                FirstName = FirstName.Text,
                LastName = LastName.Text,
                Email = Email.Text,
                Address = Address.Text,
                Hash_Id = User.Identity.GetUserId(),
                Phone = Phone.Text
            };
            Helper.addToUserTable(customUser);
            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        }
        else
        {
            ErrorMessage.Text = result.Errors.FirstOrDefault();
        }
    }
}