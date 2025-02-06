using Ede.Uof.Utility.Page.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class CDS_XML_Default : Ede.Uof.Utility.Page.BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        XElement formXE = new XElement("Form",new XAttribute("formVerionId", Guid.NewGuid().ToString()), new XAttribute("urgentLevel", "2"));
        XElement applicantXE = new XElement("Applicant", new XAttribute("account","Tony")
            , new XAttribute("groupId", ""), new XAttribute("jobTitleId", ""));

        XElement commentXE = new XElement("Comment", "This is a comment");

        XElement formFieldValueXE = new XElement("FormFieldValue");

        XElement fieldItemNoXE = new XElement("FieldItem", new XAttribute("fieldId","NO")
            , new XAttribute("fieldValue", "A001"));

        XElement fieldItemA01XE = new XElement("FieldItem", new XAttribute("fieldId", "A01")
            , new XAttribute("fieldValue", "事假"));

        XElement fieldItemA02XE = new XElement("FieldItem", new XAttribute("fieldId", "A02")
            , new XAttribute("fieldValue", "2025/02/06"));

        formXE.Add(applicantXE);
        formXE.Add(formFieldValueXE);

        applicantXE.Add(commentXE);

        formFieldValueXE.Add(fieldItemNoXE,fieldItemA01XE, fieldItemA02XE);
        txtXML.Text = formXE.ToString();
        return;
        XElement contactList = new XElement("ContactList"
            ,new XElement("Contact" , new XAttribute("name","Emma"), new XAttribute("Phone", "0912345678"))
             , new XElement("Contact", new XAttribute("name", "Tommy"), new XAttribute("Phone", "0956565656"))
          ,new XElement("Contact", new XAttribute("name", "David"), new XAttribute("Phone", "0987654321"))
            );

        txtXML.Text = contactList.ToString(  SaveOptions.DisableFormatting );
        return;

        //<FieldValue>
        //  <Item id='A01' value='V01' />
        //  <Item id='A02' value='V02' >InnerText</Item>
        //  <Item id='A03' value='V03' />
        //<FieldValue>

        XmlDocument xmlDoc = new XmlDocument();
        //<FieldValue/>
        XmlElement fieldValueElement = xmlDoc.CreateElement("FieldValue");

        //  <Item id='A01' value='V01' ></Iteem>        //
        XmlElement item01Element = xmlDoc.CreateElement("Item");
        item01Element.SetAttribute("id" , "A01");
        item01Element.SetAttribute("value", "V01");

        //  <Item id='A02' value='V02' >InnerText</Iteem>        //
        XmlElement item02Element = xmlDoc.CreateElement("Item");
        item02Element.SetAttribute("id", "A02");
        item02Element.SetAttribute("value", "V02");
        item02Element.InnerText = "InnerTextxxxxx";

        //  <Item id='A03' value='V03' ></Iteem>        //
        XmlElement item03Element = xmlDoc.CreateElement("Item");
        item03Element.SetAttribute("id", "A03");
        item03Element.SetAttribute("value", "V<0>3");

        fieldValueElement.AppendChild(item01Element);
        fieldValueElement.AppendChild(item02Element);
        fieldValueElement.AppendChild(item03Element);

        xmlDoc.AppendChild(fieldValueElement);

        txtXML.Text = xmlDoc.OuterXml;



    }
    protected void btnGetValue_Click(object sender, EventArgs e)
    {
        XElement formXE = XElement.Parse(txtXML.Text);
        var fieldItemXE = formXE.Element("FormFieldValue").Elements("FieldItem")
            .Where(x => x.Attribute("fieldId").Value == txtID.Text)
            .FirstOrDefault();
        txtValue.Text = fieldItemXE.Attribute("fieldValue").Value;
        return;
        XElement contactList = XElement.Parse(txtXML.Text);
        var contact = contactList.Elements("Contact").
            Where(x => x.Attribute("name").Value == txtID.Text)
            .FirstOrDefault();
        txtValue.Text = contact.Attribute("Phone").Value;
        return;
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.LoadXml(txtXML.Text);

        //<FieldValue>
        //  <Item id='A01' value='V01' />
        //  <Item id='A02' value='V02' >InnerText</Item>
        //  <Item id='A03' value='V03' />
        //<FieldValue>

        txtValue.Text = xmlDoc.SelectSingleNode
            (string.Format("./FieldValue/Item[@id='{0}']", txtID.Text))
            .Attributes["value"].Value;
    }
}