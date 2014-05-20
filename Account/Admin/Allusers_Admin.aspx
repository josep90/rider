<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Allusers_Admin.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

  <div class="container content">
      <h1>Users</h1>
         <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" PageSize="20" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="table" EnableModelValidation="False" DataKeyNames="Id">
             <Columns>
                 <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" >
                 <ItemStyle Font-Size="Small" />
                 </asp:BoundField>
                 <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" >
                 <ItemStyle Font-Size="Small" />
                 </asp:BoundField>
                 <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" >
                 <ItemStyle Font-Size="Small" />
                 </asp:BoundField>
                 <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" >
                 <ItemStyle Font-Size="Small" />
                 </asp:BoundField>
                 <asp:CommandField ShowSelectButton="True" ShowDeleteButton="True" ShowEditButton="True" >
                 <ItemStyle Font-Size="Small" />
                 </asp:CommandField>
             </Columns>
             <EditRowStyle BackColor="#999999" />
             <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
             <HeaderStyle BackColor="#2684B7" Font-Bold="True" ForeColor="White" />
             <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
             <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
             <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
             <SortedAscendingCellStyle BackColor="#E9E7E2" />
             <SortedAscendingHeaderStyle BackColor="#506C8C" />
             <SortedDescendingCellStyle BackColor="#FFFDF8" />
             <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
         </asp:GridView>
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" 
             SelectCommand="SELECT [Id], [FirstName], [LastName], [Email], [UserName] FROM [Users] WHERE ([Id] &lt;&gt; @Id)"
             DeleteCommand="DELETE FROM [Users] WHERE [Id] = @original_Id"
             OldValuesParameterFormatString="original_{0}" 
             UpdateCommand="UPDATE [Users] SET [FirstName] = @FirstName, [LastName] = @LastName, [Email] = @Email, [Username] = @UserName WHERE [Id] = @original_Id " ProviderName="<%$ ConnectionStrings:RidersConnectionConnectionString.ProviderName %>">
             <DeleteParameters>
                 <asp:Parameter Name="original_Id" Type="Int32" />
             </DeleteParameters>
             <SelectParameters>
                 <asp:SessionParameter DefaultValue="25" Name="Id" SessionField="UserId" Type="Int32" />
             </SelectParameters>
             <UpdateParameters>
                 <asp:Parameter Name="FirstName" Type="String" />
                 <asp:Parameter Name="LastName" Type="String" />
                 <asp:Parameter Name="Email" Type="String" />
                 <asp:Parameter Name="UserName" Type="String" />
                 <asp:Parameter Name="original_Id" Type="Int32" />
             </UpdateParameters>
         </asp:SqlDataSource>
 </div>
</asp:Content>

