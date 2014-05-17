<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="review.aspx.cs" Inherits="Review" %>
<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container content">
        <div id="container">
            <div id="content">
                <h1>How was the ride?</h1>
                <div id="respond">
                    <div class="form-group">
                        <label for="ddlRatings">Ratings</label>
                        <asp:DropDownList ID="ddlRatings" CssClass="form-control" name="ddlRatings" runat="server" Width="138px">
                            <asp:ListItem Value="1">Poor</asp:ListItem>
                            <asp:ListItem Value="2">Unsatisfactory</asp:ListItem>
                            <asp:ListItem Value="3">Average</asp:ListItem>
                            <asp:ListItem Value="4">Excellent</asp:ListItem>
                            <asp:ListItem Value="5">Highly Recommended</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label  for="txtComments">Comments</label>
                        <asp:TextBox ID="txtComments" CssClass="form-control" name="txtComments" runat="server" TextMode="MultiLine" Height="48px" Width="220px"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Button ID="btnSubmit" runat="server"  CssClass="btn btn-success" Text="SUBMIT" OnClick="btnSubmit_Click" />
                        <asp:HiddenField ID="txtOfferLockId" runat="server" />                        
                    </div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</asp:Content>

