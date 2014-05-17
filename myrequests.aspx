<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="myrequests.aspx.cs" Inherits="MyRequests" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            width: 120px;
        }

        .width200 {
            width: 200px;
        }

        .width300 {
            width: 300px;
        }

        .auto-style-1 {
            background-color: #FF9900;
        }

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container content">
        <h1>My Requests</h1>
         <br />    
        <asp:DataList ID="DataList1" runat="server" CssClass="table" DataSourceID="SqlDataSource1" ForeColor="#333333" OnItemCommand="DataList1_ItemCommand">
            <HeaderTemplate>               
                    <th class="col-center auto-style-1">Offer Id</th>
                    <th class="col-center auto-style-1">Offerer</th>
                    <th class="col-center auto-style-1">From</th>
                    <th class="col-center auto-style-1">To</th>
                    <th class="col-center auto-style-1">Rate</th>
                    <th class="col-center auto-style-1">Distance</th>
                    <th class="col-center auto-style-1">Amount</th>
                    <th class="col-center auto-style-1">Status</th>
                    <th class="col-center auto-style-1"></th>                
            </HeaderTemplate>
            <ItemTemplate>
                
                    <td class="col-center">
                        <asp:Label ID="Offer_IdLabel" runat="server" Text='<%# Eval("Offer_Id") %>' />
                    </td>
                    <td class="">
                        <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("FirstName")  + " " + Eval("LastName")%>' />
                    </td>
                    <td class="width200">
                        <asp:Label ID="FromLabel" runat="server" Text='<%# Eval("From") %>' />
                    </td>
                    <td class="width200">
                        <asp:Label ID="ToLabel" runat="server" Text='<%# Eval("To") %>' />
                    </td>
                    <td class="col-right">
                        <asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate", "{0:c}") %>' />
                    </td>
                    <td class="col-right">
                        <asp:Label ID="DistanceLabel" runat="server" Text='<%# Eval("Trip_Distance") + " mi." %>' />
                    </td>
                    <td class="col-right">
                        <asp:Label ID="AmountLabel" runat="server" Text='<%# Eval("Amount","{0:c}") %>' />
                    </td>
                    <td class="col-center">
                        <asp:Label ID="StatusLabel" runat="server" 
                            Text='<%# (Eval("Status").ToString() == "0") ? "Waiting for Approval" : ((Eval("Status").ToString() == "1") ? "Approved" : ((Eval("Status").ToString() == "2") ? "Denied" : ((Eval("Status").ToString() == "3") ? "Reserved" : "Closed")))  %>' /></td>
                    <td class="col-center">
                        <asp:Button ID="Pay" runat="server" CommandName="Pay" Text="Confirm" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Visible='<%# (Eval("Status").ToString() == "1") %>' />
                        <asp:Button ID="Close" runat="server" CommandName="Close" Text="Review" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Visible='<%# (Eval("Status").ToString() == "3") %>' />
                    </td>    
                            
            </ItemTemplate>            
            <FooterTemplate>
                

            </FooterTemplate>
        </asp:DataList>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>"
            SelectCommand="SELECT Offer_Lock.Id Offer_Lock_Id, Offer_Lock.Offer_Id, Offer_Lock.Status, Offer_Lock.[From], Offer_Lock.[To], Offer_Lock.Trip_Distance, Offer_Lock.User_Id, Offers.Rate, (Offer_Lock.Trip_Distance * Offers.Rate) Amount , Offers.Capacity, Users.FirstName, Users.LastName FROM Offer_Lock INNER JOIN Offers ON Offer_Lock.Offer_Id = Offers.Id INNER JOIN Users ON Offer_Lock.User_Id = Users.ID WHERE (Offer_Lock.User_Id = @UserID)">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserId" Type="Int32" DefaultValue="6" />
            </SelectParameters>
        </asp:SqlDataSource>    
</asp:Content>

