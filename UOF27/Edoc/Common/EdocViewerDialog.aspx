<%@ Page Title="" Language="C#" MasterPageFile="~/Master/DialogMasterPage.master" AutoEventWireup="true" CodeBehind="EdocViewerDialog.aspx.cs" Inherits="Ede.Uof.Web.Edoc.Common.EdocViewerDialog" %>

<%@ Register Src="~/Edoc/Common/UC_EdocViewer.ascx" TagPrefix="uc1" TagName="UC_EdocViewer" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        Sys.Application.add_load(function () {

        });
    </script>

    <asp:UpdatePanel ID="updatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <uc1:UC_EdocViewer runat="server" ID="UC_EdocViewer" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hfViewerHeight" runat="server" />

    <div style="margin: 0; position: absolute; top: 50%;left: 50%; -ms-transform: translate(-50%, -50%); transform: translate(-50%, -50%);">
        <asp:Label ID="lblPDFHavePassword" runat="server" Text="公文檔案(print.pdf)已被加密 ，無法預覽公文內容" Visible="false" ForeColor="Red"></asp:Label>
    </div>
</asp:Content>
