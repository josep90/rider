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
            width: 140px;
            text-align: center;
        }

        .auto-style2 {
            width: 100px;
            text-align: left;
        }

        .auto-style3 {
             font-weight: bold;
            text-align: center;
            background-color: #FF9900;
        }

        .auto-style4 {
            font-weight: bold;
            text-align: center;
            background-color: #FF9900;
        }

        .auto-style5 {
            text-align: center;
            font-weight: bold;
            background-color: #FF9900;
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
            <div style="width: 150px; float: left">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="offerDetailDataSource" Height="105px" Width="149px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <EditRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <Fields>
                        <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate">
                            <ControlStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Capacity" HeaderText="Capacity" SortExpression="Capacity" />
                        <asp:BoundField DataField="MaxDistance" HeaderText="MaxDistance" SortExpression="MaxDistance" />
                    </Fields>
                    <FooterStyle BackColor="Tan" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                </asp:DetailsView>
            </div>
            <div style="float: left">
                <asp:DataList ID="DataList1" runat="server" CssClass="table" CellPadding="4" DataKeyField="Offer_Lock_ID" DataSourceID="offersStatusDataSource" ForeColor="#333333" Width="600px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" OnItemCommand="DataList1_ItemCommand" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">
                    <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderTemplate>
                        <td class="auto-style4"><strong>Requested By</strong></td>
                        <td class="auto-style4">From</td>
                        <td class="auto-style4">To</td>
                        <td class="auto-style5">Dist.</td>
                        <td class="auto-style4">Status</td>
                        <td class="auto-style3">&nbsp;</td>

                    </HeaderTemplate>
                    <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <ItemTemplate>

                        <td class="auto-style2">
                            <asp:Label ID="User_IDLabel" runat="server" Text='<%# Eval("FIRSTNAME") + " " +  Eval("LASTNAME")%>' />
                        </td>
                        <td class="width200">
                            <asp:Label ID="FromLabel" runat="server" Text='<%# Eval("FROM").ToString() %>' />
                        </td>
                        <td class="width200">
                            <asp:Label ID="ToLabel" runat="server" Text='<%# Eval("TO").ToString() %>' />
                        </td>
                        <td class="">
                            <asp:Label ID="TripDistanceLabel" runat="server" Text='<%# Eval("Trip_distance").ToString()  + " mi." %>' />
                        </td>
                        <td class="">
                            <asp:Label ID="StatusLabel" runat="server" Text='<%# (Eval("Status").ToString() == "0") ? "New" : ((Eval("Status").ToString() == "1") ? "Accepted" : ((Eval("Status").ToString() == "2") ? "Rejected" : "Locked"))  %>' />
                        </td>

                        <td class="auto-style1">
                            <asp:Button ID="Accept" runat="server" CommandName="Accept" Text="Accept" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Enabled='<%# (Eval("maxstatus").ToString() != "3" && Eval("Status").ToString() != "1") %>' />
                            <asp:Button ID="Reject" runat="server" CommandName="Reject" Text="Reject" CommandArgument='<%# Eval("Offer_Lock_ID") %>' Enabled='<%# (Eval("maxstatus").ToString() != "3" && Eval("Status").ToString() != "2") %>' />
                        </td>

                    </ItemTemplate>
                    <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
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
