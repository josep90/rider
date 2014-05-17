<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="myoffers.aspx.cs" Inherits="Default2" %>

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

        .width100 {
            width: 100px;
            text-align: center;
        }

        .width200 {
            width: 200px;
        }

        .width300 {
            width: 300px;
        }

        .width50 {
            width: 50px;
            text-align: right;
        }

        .width140 {
            width: 140px;
        }

        .table-center {
            margin: 0 auto 0 0px;
        }

        .newStyle1 {
            text-align: center;
        }

        .newStyle2 {
            width: 100px;
        }

        .auto-style1 {
            background-color: #FF9900;
            text-align: center;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Maincontent" runat="Server">
    <div class="container content">
        <br />
        <div class="form-inline" style="text-align: center">
            <label for="ddlOfferID">My Offers:</label>
            <asp:DropDownList ID="ddlOfferID" runat="server" AutoPostBack="True" CssClass="form-control" DataSourceID="offersDataSource" DataTextField="address" DataValueField="id"></asp:DropDownList>
        </div>
        <br />
        <div style="margin: 0 auto;">
            <div style="margin:10px; float:right">
                <asp:ListView ID="ListView1" runat="server" DataSourceID="offerDetailDataSource" >
                    <ItemTemplate>
                        <td  runat="server" style="width:100px;font-weight:bold;text-align:right">Rate :&nbsp;</td>
                        <td>
                            <asp:Label ID="RateLabel" runat="server" Text='<%# Eval("Rate","{0:C}") %>' />
                        </td>
                        <td style="width:100px;font-weight:bold;text-align:right">Capacity :&nbsp;</td>
                        <td>
                            <asp:Label ID="CapacityLabel" runat="server" Text='<%# Eval("Capacity") %>' />
                        </td>
                        <td style="width:125px;font-weight:bold;text-align:right">Max. Distance:&nbsp;</td>
                        <td>
                            <asp:Label ID="MaxDistanceLabel" runat="server" Text='<%# Eval("MaxDistance")  + " mi."%>' />
                        </td>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
            <div>
                <asp:DataList ID="DataList1" runat="server" CssClass="table" CellPadding="4" DataKeyField="Offer_Lock_ID" DataSourceID="offersStatusDataSource" ForeColor="#333333" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" OnItemCommand="DataList1_ItemCommand" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">
                    <HeaderTemplate>
                        <td class="auto-style1"><strong>Requested By</strong></td>
                        <td class="auto-style1">From</td>
                        <td class="auto-style1">To</td>
                        <td class="auto-style1">Dist.</td>
                        <td class="auto-style1">Status</td>
                        <td class="auto-style1">&nbsp;</td>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <td>
                            <asp:Label ID="User_IDLabel" runat="server" Text='<%# Eval("FIRSTNAME") + " " +  Eval("LASTNAME")%>' />
                        </td>
                        <td class="width200">
                            <asp:Label ID="FromLabel" runat="server" Text='<%# Eval("FROM").ToString() %>' />
                        </td>
                        <td class="width200">
                            <asp:Label ID="ToLabel" runat="server" Text='<%# Eval("TO").ToString() %>' />
                        </td>
                        <td class="col-right">
                            <asp:Label ID="TripDistanceLabel" runat="server" Text='<%# Eval("Trip_distance").ToString()  + " mi." %>' />
                        </td>
                        <td class="col-center">
                            <asp:Label ID="StatusLabel" runat="server" 
                                Text='<%# (Eval("Status").ToString() == "0") ? "New" : ((Eval("Status").ToString() == "1") ? "Approved" : ((Eval("Status").ToString() == "2") ? "Denied" : ((Eval("Status").ToString() == "3") ? "Reserved" : "Closed")))  %>' /></td>
            
                        </td>

                        <td>
                            <asp:Button ID="Accept" runat="server" CommandName="Accept" Text="Accept" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Visible='<%# ((Eval("maxstatus").ToString() != "3" && Eval("maxstatus").ToString() != "4") && Eval("Status").ToString() != "1") %>' />
                            <asp:Button ID="Reject" runat="server" CommandName="Reject" Text="Reject" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Visible='<%# ((Eval("maxstatus").ToString() != "3" && Eval("maxstatus").ToString() != "4") && Eval("Status").ToString() != "2") %>' />
                        </td>

                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
    <br />
    <asp:SqlDataSource ID="offerDetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" SelectCommand="SELECT [Address], [Rate], [Capacity], [MaxDistance] FROM [Offers] WHERE ([Id] = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlOfferID" DefaultValue="-1" Name="Id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="offersStatusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>"
        SelectCommand="SELECT Offer_Lock.Id Offer_Lock_ID, Offer_Lock.Offer_ID OFFER_ID, [Offer_Lock].[From], [Offer_Lock].[To], [Offer_Lock].[Trip_distance], (SELECT max(Status) FROM [dbo].[Offer_Lock] where offer_id = @Offers_Id) maxstatus, Offer_Lock.Status status, Offer_Lock.User_Id offer_lock_user_id, Users.FIRSTNAME, Users.LASTNAME FROM Offer_Lock INNER JOIN Users ON Offer_Lock.User_Id = Users.ID WHERE (Offer_Lock.Offer_Id = @Offers_Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlOfferID" Name="Offers_Id"
                PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="offersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:RidersConnectionConnectionString %>" SelectCommand="SELECT Id, Address FROM Offers WHERE (User_ID = @UserID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="UserID" SessionField="Userid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
