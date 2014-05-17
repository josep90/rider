<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="styles/layout.css" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container content">
      <h1>Forgot my Password</h1>
    
      <div id="respond">
       
            
          <p>
              <asp:TextBox ID="txtEmailAddress" runat="server"></asp:TextBox>
            <label><small>Enter email/username </small></label>
          </p>
          <p>
              <asp:TextBox ID="txtSecurityQuestion" runat="server" ReadOnly="True" Width="222px"></asp:TextBox>
             <small> <asp:Label ID="SecurityQuestion" runat="server">Security Question</asp:Label></small>
           
          </p>
          <p>
              <asp:TextBox ID="txtSecurityAnswer" runat="server" ReadOnly="True" Width="220px"></asp:TextBox>
             <small> <asp:Label ID="SecurityAnswer" runat="server">Security Answer</asp:Label></small>
           
          </p>
          <p>
              <asp:TextBox ID="txtTypeyourAnswer" runat="server" Width="215px"></asp:TextBox>
            <small>  <asp:Label ID="Typeyouranswer" runat="server">Please type your answer</asp:Label></small>
           
          </p>
           <p>
              <asp:TextBox ID="txtNewPassword" runat="server" Width="215px"></asp:TextBox>
            <small>  <asp:Label ID="lblNewPassword" runat="server">Please type your new password</asp:Label></small>
           
          </p>


            
            <p>
                <asp:Button ID="btnSubmit" runat="server" Text="SUBMIT" OnClick="btnSubmit_Click" />
                <asp:Button ID="ChangePassword" runat="server" Text="SUBMIT" OnClick="ChangePassword_Click"  />
                 <asp:Button ID="btnChangePassword" runat="server" Text="CHANGE" OnClick="btnChangePassword_Click"   />
            &nbsp;
            </p>
         <p>
             <asp:Label ID="Label1" runat="server" style="font-weight: 700; font-size: medium" ></asp:Label></p>
      </div>
    </div>
</asp:Content>

