<%@ Page Title="" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="DetailFieldWithVerticalExample.aspx.cs" Inherits="WKF_FormManagement_DetailFieldWithVerticalExample" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblVerticalTitle" runat="server" Text="■明細欄位直向顯示" meta:resourcekey="lblVerticalTitleResource1"></asp:Label>
    <br />
    <asp:Image ID="ImageVertical" runat="server" ImageUrl="../Images/DetailFieldWithVerticalExample1.png"/>
    <br />
    <asp:Label ID="lblHorizontalTitle" runat="server" Text="■明細欄位橫向顯示" meta:resourcekey="lblHorizontalTitleResource1"></asp:Label>
    <br />
    <asp:Image ID="ImageHorizontal" runat="server" ImageUrl="../Images/DetailFieldWithVerticalExample2.png"/>
</asp:Content>
