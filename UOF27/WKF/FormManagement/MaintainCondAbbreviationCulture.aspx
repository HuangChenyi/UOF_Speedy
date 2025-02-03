<%@ Page Title="" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="MaintainCondAbbreviationCulture.aspx.cs" Inherits="Ede.Uof.Web.WKF.FormManagement.MaintainCondAbbreviationCulture" %>
<%@ Register src="UC_AbbreviationCultureCollection.ascx" tagname="UC_AbbreviationCultureCollection" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <uc1:UC_AbbreviationCultureCollection ID="UC_AbbreviationCultureCollection1" 
        runat="server" /> 
    <asp:CustomValidator ID="CustomValidator3" runat="server"  Display=Dynamic 
        meta:resourcekey="CustomValidator3Resource1" ></asp:CustomValidator>
</asp:Content>
