<%@ Control Language="C#" AutoEventWireup="true" Inherits="WKF_FormManagement_VersionFieldUserControl_UC_FieldCultureCollection" Codebehind="UC_FieldCultureCollection.ascx.cs" %>
<%@ Register src="UC_FieldCulture.ascx" tagname="UC_FieldCulture" tagprefix="uc1" %>
<%@ Register src="UC_FieldDataListCulture.ascx" tagname="UC_FieldDataListCulture" tagprefix="uc2" %>
<%@ Register src="UC_DataListCulture.ascx" tagname="UC_DataListCulture" tagprefix="uc3" %>
<%@ Register src="UC_DataGridCulture.ascx" tagname="UC_DataGridCulture" tagprefix="uc4" %>

<script>
    Sys.Application.add_load(function () {

        var hfHyperLinkId = '<%=hfHyperLinkId.ClientID %>';
        var hfHyperLinkIdValue = $("#" + hfHyperLinkId).val();

        if (hfHyperLinkIdValue !== '')
            FocusHyperLink(hfHyperLinkIdValue);
    });

    function FocusHyperLink(hyperLinkId) {
        $("#" + hyperLinkId + "").focus();
    };

</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Label ID="lblWriteFieldTip" runat="server" Text="註：啟用語系前請填寫該語系所有欄位名稱與欄位值" ForeColor="Blue" meta:resourcekey="lblWriteFieldTipResource1"></asp:Label>
        <div style="margin-bottom:10px;"></div>
        <asp:Label ID="lblFieldNameWriteMessage" runat="server" Text="欄位名稱多國語必填" Visible="false" meta:resourcekey="lblFieldNameWriteMessageResource1"></asp:Label>

        <asp:Table ID="Table1" runat="server" width="100%" meta:resourcekey="Table1Resource1"></asp:Table>
        <asp:Label ID="lblDefault" runat="server" Text="還原" Visible="false" meta:resourcekey="lblDefaultResource1"></asp:Label>
        <asp:Label ID="lblView" runat="server" Text="預覽" Visible="false" meta:resourcekey="lblViewResource1"></asp:Label>
        <asp:Label ID="lblEnable" runat="server" Text="啟用" Visible="false" meta:resourcekey="lblEnableResource1"></asp:Label>
        <asp:Label ID="lblDisable" runat="server" Text="停用" Visible="false" meta:resourcekey="lblDisableResource1"></asp:Label>
        <asp:Label ID="lblDefalutCulture" runat="server" Text="預設語系" Visible="false" meta:resourcekey="lblDefalutCultureResource1"></asp:Label>

        <asp:HiddenField ID="hfHyperLinkId" runat="server" />
        <asp:HiddenField ID="hfFileName" runat="server" ></asp:HiddenField>
    </ContentTemplate>
</asp:UpdatePanel>
 
