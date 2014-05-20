<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="User_UpdatePassword.aspx.cs" Inherits="UpdatePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="content container">
         <h1>My Privacy Settings</h1>
            <asp:FormView ID="FormView1" runat="server" BorderStyle="None" CellPadding="4" DataSourceID="SqlDataSource1" Width="500px" CssClass="table">
                <EditItemTemplate>
                    <p>Change Privacy&nbsp; Details</p>
                    <table style="width: 100%">
                        <tr>
                            <td class="right" style="width: 169px">Email</td>
                            <td>
                                <asp:TextBox ID="EmailTextBox" runat="server" ReadOnly="True" Text='<%# Bind("Email") %>' Width="300px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="right" style="width: 169px">Password</td>
                            <td>
                                <asp:TextBox ID="PasswordTextBox" runat="server" Text='<%# Bind("Password") %>' Width="300px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="right" style="width: 169px">Security Question</td>
                            <td>
                                <asp:TextBox ID="Security_QuestionTextBox" runat="server" Text='<%# Bind("Security_Question") %>' Width="300px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="right" style="width: 169px">Answer</td>
                            <td>
                                <asp:TextBox ID="Security_answerTextBox" runat="server" Text='<%# Bind("Security_answer") %>' Width="300px" />
                            </td>
                        </tr>
                    </table>
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ForeColor="Black" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" ForeColor="Black" />
                </EditItemTemplate>
                <EditRowStyle BackColor="#B7DCF0" Font-Bold="True" />
                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
              
              
                <ItemTemplate>
                    Change Privacy Details<br />
                    <table style="width: 100%">
                        <tr>
                            <td class="right" style="width: 167px">Email</td>
                            <td>
                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("Email") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="right" style="width: 167px">Password</td>
                            <td>
                                <asp:Label ID="PasswordLabel" runat="server" Text='<%# Bind("Password") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="right" style="width: 167px">Security Question</td>
                            <td>
                                <asp:Label ID="Security_QuestionLabel" runat="server" Text='<%# Bind("Security_Question") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td class="right" style="width: 167px">Answer</td>
                            <td>
                                <asp:Label ID="Security_answerLabel" runat="server" Text='<%# Bind("Security_answer") %>' />
                            </td>
                        </tr>
                    </table>
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Font-Bold="True" ForeColor="Black" />

                  
                </ItemTemplate>
                <PagerStyle BackColor="#2684B7" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="White" ForeColor="#666666" />
            </asp:FormView>
         </div>   
    
      <div class="subnav">
        <h2>Quick Links</h2>
        <ul>
            <li><a href="/Account/Profile">Update Personal Info</a> </li>
            <li><a href="/Account/User_UpdatePassword">Change Privacy Settings</a> </li>
        </ul>
      </div>
   <div class="clear">
       <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" 
           SelectCommand="SELECT [Email], [Password], [Security_Question], [Security_Answer] FROM [Users] WHERE ([Id] = @Id)"
           UpdateCommand="UPDATE [Users] SET Password = @password, Email = @email, Security_Question = @question, Security_answer = @answer WHERE ([Id] = @Id)">
           <SelectParameters>
               <asp:SessionParameter Name="Id" SessionField="UserId" Type="Int32" />
           </SelectParameters>
            <UpdateParameters>
               <asp:Parameter Name="password" />
               <asp:Parameter Name="email" />
               <asp:Parameter Name="question" />
               <asp:Parameter Name="answer" />
           </UpdateParameters>
       </asp:SqlDataSource>
      </div>
</asp:Content>

