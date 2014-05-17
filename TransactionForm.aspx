<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TransactionForm.aspx.cs" Inherits="_Default" %>

<%@ MasterType VirtualPath="~/Site.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="styles/layout.css" type="text/css" />
    <style type="text/css">
        .auto-style1 {
            width: 160px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container content">
        <br />
        <h4>Amount</h4>
        <p>
            <label>Amount : &nbsp;</label>
            <asp:Label ID="AmountLabel" runat="server" Width="98px" Style="font-weight: 700; font-size: large">120.00</asp:Label>
            <asp:HiddenField ID="txtAmount" runat="server" Value="" />
        </p>
        <br />
        <table style="border-collapse: separate; border-spacing: 5px;">
            <tr>
                <td colspan="3">
                    <h4>Credit Card Information</h4>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <label for="ddlCardType"><small>Card Type*</small></label></td>
                <td>
                    <asp:DropDownList ID="ddlCardType" runat="server" CssClass="form-control">
                        <asp:ListItem Value="1">MasterCard</asp:ListItem>
                        <asp:ListItem Value="2">Visa</asp:ListItem>
                        <asp:ListItem Value="3">American Express</asp:ListItem>
                        <asp:ListItem Value="4">Discover</asp:ListItem>
                    </asp:DropDownList></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCardType" ErrorMessage="Please choose your card type" ForeColor="#FF0066"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <label><small>Card Number*</small></label></td>
                <td>
                    <asp:TextBox ID="txtCardNumber" runat="server" Width="133px" CssClass="form-control" value="879578354664"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCardNumber" ErrorMessage="Please Enter your card number." ForeColor="#FF0066"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <label>Expiration Date*</label></td>
                <td>
                    <asp:DropDownList ID="expiryMonth" runat="server">
                        <asp:ListItem Value=""> </asp:ListItem>
                        <asp:ListItem Value="01">Jan</asp:ListItem>
                        <asp:ListItem Value="02">Feb</asp:ListItem>
                        <asp:ListItem Value="03">Mar</asp:ListItem>
                        <asp:ListItem Value="04">Apr</asp:ListItem>
                        <asp:ListItem Value="05">May</asp:ListItem>
                        <asp:ListItem Value="06">Jun</asp:ListItem>
                        <asp:ListItem Value="06">Jul</asp:ListItem>
                        <asp:ListItem Value="07">Aug</asp:ListItem>
                        <asp:ListItem Value="09">Sep</asp:ListItem>
                        <asp:ListItem Value="10">Oct</asp:ListItem>
                        <asp:ListItem Value="11">Nov</asp:ListItem>
                        <asp:ListItem Value="12">Dec</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="expiryYear" runat="server">
                        <asp:ListItem> </asp:ListItem>
                        <asp:ListItem>2014</asp:ListItem>
                        <asp:ListItem>2015</asp:ListItem>
                        <asp:ListItem>2016</asp:ListItem>
                        <asp:ListItem>2017</asp:ListItem>
                        <asp:ListItem>2018</asp:ListItem>
                    </asp:DropDownList></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Choose Month" ControlToValidate="expiryMonth" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Choose expiry  Year" ControlToValidate="expiryYear" ForeColor="#FF0066"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <label><small>3-digits Security Code*</small></label></td>
                <td>
                    <asp:TextBox ID="txtSecuritycode" runat="server" Width="52px" value="739" CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSecuritycode" ErrorMessage="Please enter your 3 digit number" ForeColor="Red"></asp:RequiredFieldValidator></td>
            </tr>
        </table>
        <br />
        <table style="border-collapse: separate; border-spacing: 5px;">
            <tr>
                <td colspan="3">
                    <h4>Billing Address</h4>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <label><small>&nbsp; Full Name*</small></label></td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" Width="218px" value="John Smith" CssClass="form-control"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required" ControlToValidate="txtName" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td class="auto-style1">
                    <label><small>&nbsp; Billing Address *</small></label></td>
                <td>
                    <asp:TextBox ID="txtBillingAddress1" value="1075 North Benson Road" CssClass="form-control" runat="server" Width="217px" MaxLength="10"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Required" ControlToValidate="txtBillingAddress1" ForeColor="#FF0066"></asp:RequiredFieldValidator></td>

            </tr>




            <tr>
                <td class="auto-style1">
                    <label><small>&nbsp; Floor*</small></label></td>
                <td>
                    <asp:TextBox ID="txbBillingAddress2" value="BNW318" runat="server" CssClass="form-control" Width="216px"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Required" ControlToValidate="txbBillingAddress2" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>

            </tr>

            <tr>
                <td class="auto-style1">
                    <label><small>&nbsp; City*</small></label></td>
                <td>
                    <asp:TextBox ID="txtCity" runat="server" Width="216px" CssClass="form-control" value="Fairfield"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" CssClass="form-control" runat="server" ErrorMessage="Required" ControlToValidate="txtCity" ForeColor="#FF0066"></asp:RequiredFieldValidator></td>

            </tr>
            <tr>
                <td class="auto-style1">
                    <label><small>&nbsp; State*</small></label></td>
                <td>
                    <asp:TextBox ID="txtState" value="CT" CssClass="form-control" runat="server" Width="216px"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Required" ControlToValidate="txtState" ForeColor="#FF0066"></asp:RequiredFieldValidator></td>

            </tr>
            <tr>
                <td class="auto-style1">
                    <label><small>&nbsp;Zip*</small></label></td>
                <td>
                    <asp:TextBox ID="txtZip" value="06809" runat="server" CssClass="form-control" Width="216px"></asp:TextBox></td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Required" ControlToValidate="txtZip" ForeColor="#FF0066"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td colspan="3" style="padding:10px">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" Text="SUBMIT" OnClick="btnSubmit_Click" />                  
                </td>
            </tr>

            <asp:HiddenField ID="txtOfferLockId" runat="server" />
        </table>
        <br />
    </div>


</asp:Content>

