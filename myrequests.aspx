<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="myrequests.aspx.cs" Inherits="MyRequests" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="stylesheet" href="styles/layout.css" type="text/css" />
    <style type="text/css">
        .col-left {
            text-align: left;
        }

        .col-right {
            text-align: right;
        }

        .col-center {
            text-align: center;
        }

        .width50 {
            width: 50px;
        }
        .width100 {
            width: 100px;            
        }

        .width120 {
            width:120px;
        }

        .width200 {
            width: 200px;
        }

        .width300 {
            width: 300px;
        }

        .table-center {
            margin: 0 auto;
        }
        .auto-style1 {
            background-color: #FF9900;
        }
        .auto-style2 {
            font-weight: bold;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <br />
    <div style="min-height:300px">
        <asp:DataList ID="DataList1" runat="server" CssClass="table-center" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" OnItemCommand="DataList1_ItemCommand" >
            <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
            <HeaderTemplate>
                <table class="auto-style1">
                    <tr>                       
                        <td class="auto-style2 width100 col-center">Offer Id</td>
                        <td class="auto-style2 width120 col-center">Offerer</td>
                        <td class="auto-style2 width100 col-center">From</td>
                        <td class="auto-style2 width100 col-center">To</td>
                        <td class="auto-style2 width50 col-center">Rate</td>
                        <td class="auto-style2 width50 col-center">Distance</td>
                        <td class="auto-style2 width100 col-center">Amount</td>
                        <td class="auto-style2 width100 col-center">Status</td>
                        <td class="auto-style2 width100 col-center">&nbsp;</td>
                    </tr>
                </table>
            </HeaderTemplate>
            <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <ItemTemplate>
                <table class="nav-justified">
                    <tr>
                        <td class="width100 col-center"><asp:Label ID="Offer_IdLabel" runat="server" Text='<%# Eval("Offer_Id") %>' /></td>  
                        <td class="width120"><asp:Label ID="NameLabel" runat="server" Text='<%# Eval("FirstName")  + " " + Eval("LastName")%>' /></td>                      
                        <td class="width100"><asp:Label ID="FromLabel" runat="server" Text='<%# Eval("From") %>' /></td>
                        <td class="width100"><asp:Label ID="ToLabel" runat="server" Text='<%# Eval("To") %>' /></td>
                        <td class="width50 col-right"><asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate", "{0:c}") %>' /></td>
                        <td class="width50 col-right"><asp:Label ID="DistanceLabel" runat="server" Text='<%# Eval("Trip_Distance") %>' /></td>
                        <td class="width100 col-right"><asp:Label ID="AmountLabel" runat="server" Text='<%# Eval("Amount","{0:c}") %>' /></td>
                        <td class="width100 col-center"><asp:Label ID="StatusLabel" runat="server" Text='<%# (Eval("Status").ToString() == "0") ? "New" : ((Eval("Status").ToString() == "1") ? "Accepted" : ((Eval("Status").ToString() == "2") ? "Rejected" : "Locked"))  %>' /></td>                        
                        <td class="width100 col-center">
                            <asp:Button ID="Pay" runat="server" CommandName="Pay" Text="Confirm" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Visible='<%# (Eval("Status").ToString() == "1") %>' />
                            <asp:Button ID="Close" runat="server" CommandName="Close" Text="Review" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Visible='<%# (Eval("Status").ToString() == "3") %>' />
                        </td>                        
                    </tr>
                </table>               
            </ItemTemplate>
            <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>"
             SelectCommand="SELECT Offer_Lock.Id Offer_Lock_Id, Offer_Lock.Offer_Id, Offer_Lock.Status, Offer_Lock.[From], Offer_Lock.[To], Offer_Lock.Trip_Distance, Offer_Lock.User_Id, Offers.Rate, (Offer_Lock.Trip_Distance * Offers.Rate) Amount , Offers.Capacity, Users.FirstName, Users.LastName FROM Offer_Lock INNER JOIN Offers ON Offer_Lock.Offer_Id = Offers.Id INNER JOIN Users ON Offer_Lock.User_Id = Users.ID WHERE (Offer_Lock.User_Id = @UserID)">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserId" Type="Int32" DefaultValue="6" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

