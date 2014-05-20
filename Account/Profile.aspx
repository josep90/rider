<%@ Page Title="" Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Account_Profile" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="container content">
         <h1>My Details</h1>
                    <asp:FormView ID="FormView1" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataSourceID="SqlDataSource1" Height="222px" Width="468px" CssClass="table">
             <EditItemTemplate>
                 <p>Update My Personal Information</p>
                 <table style="width: 100%">
                     <tr>
                         <td class="right" style="width: 158px">First Name</td>
                         <td>
                             <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' Width="300px" />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 158px">LastName</td>
                         <td>
                             <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' Width="300px" />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 158px">Telephone</td>
                         <td>
                             <asp:TextBox ID="TelephoneTextBox" runat="server" Text='<%# Bind("Phone") %>' Width="300px" />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 158px">Email</td>
                         <td>
                             <asp:TextBox ID="EmailTextBox" runat="server" ReadOnly="True" Text='<%# Bind("Email") %>' Width="300px" />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 158px">Address</td>
                         <td>
                             <asp:TextBox ID="Street_AddressTextBox" runat="server" Text='<%# Bind("Address") %>' Width="300px" />
                         </td>
                     </tr>
                 </table>
                 <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ForeColor="Black" />
                 &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" ForeColor="Black" />
             </EditItemTemplate>
             <EditRowStyle BackColor="#BFE0F2" Font-Bold="True" />
             <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
             <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
             
 
             
             <ItemTemplate>
                 <h2>My Personal Information</h2>
                 <table style="width: 100%">
                     <tr>
                         <td class="right" style="width: 167px">FirstName</td>
                         <td>
                             <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 167px">LastName</td>
                         <td>
                             <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 167px">Telephone</td>
                         <td>
                             <asp:Label ID="TelephoneLabel" runat="server" Text='<%# Bind("Phone") %>' />
                         </td>
                     </tr>
                     <tr>
                         <td class="right" style="width: 167px">Email</td>
                         <td>
                             <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                         </td>
                     </tr>
                 </table>
                 <table style="width: 100%">
                     <tr>
                         <td class="right" style="height: 28px; width: 163px">Address</td>
                         <td style="height: 28px">
                             <asp:Label ID="Street_AddressLabel" runat="server" Text='<%# Bind("Address") %>' />
                         </td>
                     </tr>
                 </table>
                 <br />

                 <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" ForeColor="Black" Font-Bold="True" />

             </ItemTemplate>
             <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
             <RowStyle BackColor="White" />
         </asp:FormView>
         <br /> 
       
         <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" 
             SelectCommand="SELECT [State] FROM [StateName]"></asp:SqlDataSource>
       
        <div class="subnav">
        <h2>Quick Links</h2>
        <ul>
            <li><a href="/Account/Profile">Update Personal Info</a> </li>
            <li><a href="/Account/User_UpdatePassword">Change Privacy Settings</a> </li>
        </ul>
      </div>

    </div>   
        
   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" 
        SelectCommand="SELECT [FirstName], [LastName], [Address], [Phone], [Email] FROM [Users] WHERE ([Id] = @Id)"
        UpdateCommand="UPDATE Users SET FirstName = @Firstname, LastName = @Lastname, Phone = @Phone, Address = @Address, Email=@Email WHERE ([Id] = @Id)" >
        <SelectParameters>
            <asp:SessionParameter Name="Id" SessionField="UserId" Type="Int32" DefaultValue="-1" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Firstname" />
            <asp:Parameter Name="Lastname" />
            <asp:Parameter Name="Phone" />
            <asp:Parameter Name="Address" />
            <asp:Parameter Name="Email" />
            <asp:SessionParameter Name="Id" SessionField="UserId" Type="Int32" DefaultValue="-1" />       
        </UpdateParameters>
    </asp:SqlDataSource>
   
</asp:Content>

