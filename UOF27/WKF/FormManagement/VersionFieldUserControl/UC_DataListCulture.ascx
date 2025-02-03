<%@ Control Language="C#" AutoEventWireup="true" Inherits="WKF_FormManagement_VersionFieldUserControl_UC_DataListCulture" Codebehind="UC_DataListCulture.ascx.cs" %>

<style>
    .textFloat {
        float:right;
    }
</style>

<fieldset style="border:1px solid;border-color:gray;padding:3px">
    <legend>
        <asp:Label ID="lblTitle" runat="server" 
            meta:resourcekey="lblTitleResource1"></asp:Label>
    </legend>

    <asp:Table ID="tbDataList" runat="server"  Width="100%" meta:resourcekey="tbDataListResource1"></asp:Table>

    <asp:Label ID="lblTooltip" runat="server" Text="欄位選項值不可在這編輯" Visible="false" 
        meta:resourcekey="lblTooltipResource1">
    </asp:Label>
</fieldset>

<asp:Label ID="lblEmpty" runat="server" Text="不允許空白" Visible="false" meta:resourcekey="lblEmptyResource1"></asp:Label>
<asp:Label ID="lblFieldValueWriteMessage" runat="server" Text="欄位值多國語必填" Visible="false" meta:resourcekey="lblFieldValueWriteMessageResource1"></asp:Label>