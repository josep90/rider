<%@ Page Title="" Language="C#"  MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyProfile_Admin.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="container content">
         <h1>My Details - Administrator</h1>
         <asp:FormView ID="FormView1" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataSourceID="SqlDataSource1" GridLines="Both" Height="222px" Width="468px">
             <EditItemTemplate>
                 Update My Personal Information<br />&nbsp;<table style="width: 100%">
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
                 </table>
                 <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ForeColor="Black" />
                 &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" ForeColor="Black" />
             </EditItemTemplate>
             <EditRowStyle BackColor="#2684B7" Font-Bold="True" ForeColor="White" />
             <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
             <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
             
             <ItemTemplate>
                 <br />
                 My Personal Information<br />
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
             <RowStyle BackColor="#2684B7" ForeColor="White" />
         </asp:FormView>
         <br /> 
         <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" SelectCommand="SELECT [State] FROM [StateName]"></asp:SqlDataSource>
         <br /> 
         </div>   
   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" 
        SelectCommand="SELECT FirstName, LastName, Phone, Email, Address FROM Users WHERE ([Id] = @Id)" 
        UpdateCommand="UPDATE User_Information SET FirstName = @firstname, LastName = @lastname, Phone = @phone, Address = @address WHERE ([Id] = @Id)" >
        <InsertParameters>
        </InsertParameters>
        <SelectParameters>
               <asp:SessionParameter Name="Id" SessionField="UserId" Type="Int32" />
           </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="firstname" />
            <asp:Parameter Name="lastname" />
            <asp:Parameter Name="phone" />
            <asp:Parameter Name="address" />
        </UpdateParameters>
    </asp:SqlDataSource>
   
</asp:Content>

