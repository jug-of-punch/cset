﻿/*
Run this script on:

(localdb)\v11.0.CSETWeb920    -  This database will be modified

to synchronize it with:

(localdb)\v11.0.CSETWeb921

You are recommended to back up your database before running this script

Script created by SQL Data Compare version 14.0.7.13517 from Red Gate Software Ltd at 11/25/2019 7:13:30 PM

*/
		
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION

PRINT(N'Drop constraints from [dbo].[SET_FILES]')
ALTER TABLE [dbo].[SET_FILES] NOCHECK CONSTRAINT [FK_SET_FILES_GEN_FILE]
ALTER TABLE [dbo].[SET_FILES] NOCHECK CONSTRAINT [FK_SET_FILES_SETS]

PRINT(N'Drop constraints from [dbo].[NEW_REQUIREMENT]')
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_NCSF_Category]
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_QUESTION_GROUP_HEADING]
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_SETS]
ALTER TABLE [dbo].[NEW_REQUIREMENT] NOCHECK CONSTRAINT [FK_NEW_REQUIREMENT_STANDARD_CATEGORY]

PRINT(N'Drop constraint FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT from [dbo].[FINANCIAL_REQUIREMENTS]')
ALTER TABLE [dbo].[FINANCIAL_REQUIREMENTS] NOCHECK CONSTRAINT [FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_NERC_RISK_RANKING_NEW_REQUIREMENT from [dbo].[NERC_RISK_RANKING]')
ALTER TABLE [dbo].[NERC_RISK_RANKING] NOCHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_Parameter_Requirements_NEW_REQUIREMENT from [dbo].[PARAMETER_REQUIREMENTS]')
ALTER TABLE [dbo].[PARAMETER_REQUIREMENTS] NOCHECK CONSTRAINT [FK_Parameter_Requirements_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_LEVELS]')
ALTER TABLE [dbo].[REQUIREMENT_LEVELS] NOCHECK CONSTRAINT [FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_QUESTIONS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_QUESTIONS_SETS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT from [dbo].[REQUIREMENT_REFERENCES]')
ALTER TABLE [dbo].[REQUIREMENT_REFERENCES] NOCHECK CONSTRAINT [FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_SETS_NEW_REQUIREMENT from [dbo].[REQUIREMENT_SETS]')
ALTER TABLE [dbo].[REQUIREMENT_SETS] NOCHECK CONSTRAINT [FK_REQUIREMENT_SETS_NEW_REQUIREMENT]

PRINT(N'Drop constraint FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT from [dbo].[REQUIREMENT_SOURCE_FILES]')
ALTER TABLE [dbo].[REQUIREMENT_SOURCE_FILES] NOCHECK CONSTRAINT [FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT]

PRINT(N'Drop constraints from [dbo].[NEW_QUESTION]')
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_SETS]
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SAL_LEVEL]
ALTER TABLE [dbo].[NEW_QUESTION] NOCHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SUB_CATEGORY_HEADINGS]

PRINT(N'Drop constraint FK_Component_Questions_NEW_QUESTION from [dbo].[COMPONENT_QUESTIONS]')
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] NOCHECK CONSTRAINT [FK_Component_Questions_NEW_QUESTION]

PRINT(N'Drop constraint FK_FINANCIAL_QUESTIONS_NEW_QUESTION from [dbo].[FINANCIAL_QUESTIONS]')
ALTER TABLE [dbo].[FINANCIAL_QUESTIONS] NOCHECK CONSTRAINT [FK_FINANCIAL_QUESTIONS_NEW_QUESTION]

PRINT(N'Drop constraint FK_NERC_RISK_RANKING_NEW_QUESTION from [dbo].[NERC_RISK_RANKING]')
ALTER TABLE [dbo].[NERC_RISK_RANKING] NOCHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_QUESTION]

PRINT(N'Drop constraint FK_NEW_QUESTION_SETS_NEW_QUESTION from [dbo].[NEW_QUESTION_SETS]')
ALTER TABLE [dbo].[NEW_QUESTION_SETS] NOCHECK CONSTRAINT [FK_NEW_QUESTION_SETS_NEW_QUESTION]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_NEW_QUESTION1 from [dbo].[REQUIREMENT_QUESTIONS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_QUESTION1]

PRINT(N'Drop constraint FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION from [dbo].[REQUIREMENT_QUESTIONS_SETS]')
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] NOCHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION]

PRINT(N'Delete rows from [dbo].[SET_FILES]')
DELETE FROM [dbo].[SET_FILES] WHERE [SetName] = 'ISA-62443' AND [Gen_File_Id] = 3938
DELETE FROM [dbo].[SET_FILES] WHERE [SetName] = 'TSA2018' AND [Gen_File_Id] = 3937
PRINT(N'Operation applied to 2 rows out of 2')

PRINT(N'Update rows in [dbo].[NEW_REQUIREMENT]')
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Operators of critical pipeline facilities should: Conduct an SVA or the equivalent on a periodic basis, not to exceed 36 months, and within 12 months after completion of a significant enhancement or modification to the facility' WHERE [Requirement_Id] = 29659
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='Factors such as customer base, downstream deliverability and reliability commitments, system redundancies, and operator risk tolerance may influence critical determinations. Figure 2 is provided to illustrate the facility criticality determination pathway.<div><br></div><div><br></div>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline facilities meeting any one or more of the criteria below are considered to be critical:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Pipeline operators should develop and implement baseline security measures at all of their facilities.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table><tbody><tr class="brown"><td style="width: 158.889px;"></td><td style="width: 527.778px;">BASELINE SECURITY MEASURES</td><td style="width: 527.778px;">ENHANCED SECURITY MEASURES</td></tr><tr><td rowspan="14" class="sideways gold" style="width: 158.889
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Develop identification and badging policies and procedures for personnel who have access to secure areas or sensitive information. These policies should address:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Conduct pre-employment background investigations of applicants for positions that are: Authorized regular unescorted access to control systems or sensitive areas; Authorized access to sensitive information; Assigned security roles; Assigned to work at or granted access rights to critical facilities.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='&lt;style&gt;
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='The following documents, as appropriate, should be retained until superseded or replaced: Corporate Security Plan; Criticality assessment(s); Training records; Security drill or exercise reports; Incident response plan(s); Security testing and audits.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='In addition to the documents specified for non-critical facilities, the following documents, applicable to critical facilities, should be retained until superseded or replaced: SVA(s); Site-specific measures.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<!--Table on Page 11-->
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='The operational technology used by the operators to manage their infrastructure and products are vital to the pipeline system''s safe and efficient operation. “Operational technologies” (OT) are the systems that detect or cause a change through the direct monitoring and/or control of physical devices, processes and events in the pipelines. OT systems include control systems (SCADA, process control systems (PCS), distributed control systems (DCS)), measurement systems and telemetry systems, which are collectively referred to as “pipeline cyber assets.”
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Operators should evaluate pipeline cyber assets and classify them using the following criteria:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Operators should evaluate pipeline cyber assets and classify them using the following criteria:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='brack
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><br><br><br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='Establish and enforce unique accounts for each individual user and administrator, establish security requirements for certain types of privileged accounts, and prohibit the sharing of these accounts. 
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<span style="font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, monospace;">&lt;style&gt;
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Supplemental_Info]='<br><br><table>
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='The following is a list of planning and implementation guidance developed by industry or Federal government entities. Operators should consult the current edition of these and other cyber security references on a frequent basis in developing and reviewing their company’s cyber security program.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A general product development/maintenance/support process shall be documented and enforced that is consistent and integrated with commonly accepted product development processes that include, but are not limited to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that product development life-cycle processes for components from a third-party supplier conform to the requirements used in this document when they meet the following criteria:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for verifying that a product or a patch is not released until its security-related issues have been addressed and tracked to closure (see 10.5, DM-4: Addressing security-related issues). This includes issues associated with:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that all products shall have a threat model specific to the current development scope of the product with the following characteristics (where applicable):
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for ensuring that security requirements include the following information:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that security requirements are reviewed, updated as necessary and approved to ensure clarity, validity, alignment with the threat model (discussed in 6.3 SR-2: Threat model), and their ability to be verified. Each of the following representative disciplines shall participate in this process. Personnel may be assigned to more than one discipline except for testers, who shall remain independent.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for developing and documenting a secure design that identifies and characterizes each interface of the product, including physical and logical interfaces, to include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to implement multiple layers of defense using a risk based approach based on the threat model. This process shall be employed for assigning responsibilities to each layer of defense.
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for conducting design reviews to identify, characterize and track to closure security-related issues associated with each significant revision of the secure design including but not limited to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that secure design best practices are documented and applied to the design process. These practices shall be periodically reviewed and updated. Secure design practices include but are not be limited to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that implementation reviews are performed for identifying, characterizing and tracking to closure security-related issues associated with the implementation of the secure design including:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='The implementation processes shall incorporate security coding standards that are periodically reviewed and updated and include at a minimum:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for verifying the product security functions meet the security requirements and that the product handles error scenarios and invalid input correctly. Types of testing shall include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for testing the effectiveness of the mitigation for the threats identified and validated in the threat model. Activities shall include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for performing tests that focus on identifying and characterizing potential security vulnerabilities in the product. Known vulnerability testing shall be based upon, at a minimum, recent contents of an established, industry-recognized, public source for known vulnerabilities. Testing shall include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='The levels of independence are defined as follows:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall exist for receiving and tracking to closure security-related issues in the product reported by internal and external sources including at a minimum:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall exist for ensuring that reported security-related issues are investigated in a timely manner to determine their:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for analyzing security-related issues in the product to include:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for addressing security-related issues and determining whether to report them based on the results of the impact assessment (see 10.4, DM-3: Assessing security-related issues). The supplier shall establish an acceptable level of residual risk that shall be applied when determining appropriate way to address each issue. Options include one or more of the following:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for informing product users about reportable security-related issues (see 10.5, DM-4: Addressing security-related issues) in supported products in a timely manner with content that includes but is not limited to the following information:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed for verifying:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that documentation about product security updates is made available to product users that includes but is not limited to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to ensure that documentation about dependent component or operating system security updates is made available to product users that includes but is not limited to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to define a policy that specifies the timeframes for delivering and qualifying (see SUM-1: Security update qualification) security updates to product users and to ensure that this policy is followed. At a minimum, this policy shall consider the following factors:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall exist to create product user documentation that describes the security defense in depth strategy for the product to support installation, operation and maintenance that includes:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to create product user documentation that describes the security defense in depth measures expected to be provided by the external environment in which the product is to be used (see Clause 6, Practice 2 – Specification of security requirements).
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to create product user documentation that includes guidelines for hardening the product when installing and maintaining the product. The guidelines shall include, but are not limited to, instructions, rationale and recommendations for the following:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to create product user documentation that includes guidelines for removing the product from use. The guidelines shall include, but is not limited to instructions and recommendations for the following:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to create product user documentation that describes:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to create product user documentation that defines user account requirements and recommendations associated with the use of the product that includes, but is not limited to:
UPDATE [dbo].[NEW_REQUIREMENT] SET [Requirement_Text]='A process shall be employed to identify, characterize and track to closure errors and omissions in all user manuals including the security guidelines to include:
PRINT(N'Operation applied to 134 rows out of 134')

PRINT(N'Update rows in [dbo].[NEW_QUESTION]')
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization define a critical facility (or combination of facilities) as one that meets any of the criteria and that if damaged or destroyed would have the potential to:  
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Do operators consult the following documents while developing and reviewing their company''s cyber security program:
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization employ a process to ensure that all products have a threat model specific to the current development scope with the following characteristics: 
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization''s software composition analysis detect the following types of problems at a minimum:
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization define the levels of independence for testers as:
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='When addressing security-related issues does the organization apply one or more of the following:
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization''s security update process include a validation step to ensure the patch originated from the suppliers of components used in the product?' WHERE [Question_Id] = 16520
UPDATE [dbo].[NEW_QUESTION] SET [Simple_Question]='Does the organization''s security hardening documentation include configuration and use of security options/capabilities in support of local security policies and for each security option/capability: 
PRINT(N'Operation applied to 8 rows out of 8')

PRINT(N'Update row in [dbo].[DIAGRAM_TEMPLATES]')
UPDATE [dbo].[DIAGRAM_TEMPLATES] SET [Diagram_Markup]='<mxGraphModel dx="1799" dy="1066" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="0" pageScale="1" pageWidth="850" pageHeight="1100" math="0" shadow="0">
  <root>
    <mxCell id="0"/>
    <mxCell id="1" value="Main Layer" parent="0"/>
    <object SAL="Low" label="Corporate-Low" internalLabel="Corporate" ZoneType="Corporate" zone="1" Criticality="Low" id="2">
      <mxCell style="swimlane;zone=1;labelBackgroundColor=none;fillColor=#fdf9d9;swimlaneFillColor=#fffef4;" parent="1" vertex="1" connectable="0">
        <mxGeometry x="41" y="72" width="315" height="522" as="geometry"/>
      </mxCell>
    </object>
    <object label="External Firewall" ComponentGuid="b94b6a0b-ebe5-4bf0-a2ff-7db569e2df13" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" id="5">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/firewall.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="119" y="31.1" width="60" height="51" as="geometry"/>
      </mxCell>
    </object>
    <object label="Public Historian" ComponentGuid="16b71bf0-01aa-4c69-9d30-4a719bf562a1" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" id="6">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/historian.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="207" y="408" width="48" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="Corp IDS" ComponentGuid="1af3ffe6-b3b7-46a9-92dc-06ca8f6253ef" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" id="7">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/ids.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="207" y="149.5" width="60" height="17" as="geometry"/>
      </mxCell>
    </object>
    <object label="CON-1" ComponentGuid="9d5fdc14-e6e9-487c-b74a-e46b8e4f3925" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" internalLabel="CON-1" id="8">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/connector.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="137.5" y="148" width="20" height="20" as="geometry"/>
      </mxCell>
    </object>
    <object label="Corp Router" ComponentGuid="a9073944-6f56-4ac1-85d0-56c846f6d9ec" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" id="9">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/router.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="119" y="215.5" width="60" height="25" as="geometry"/>
      </mxCell>
    </object>
    <object label="Corp Switch" ComponentGuid="4a45079c-c584-481d-99e9-49ac131e1e46" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" id="10">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/switch.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="119" y="313" width="60" height="23" as="geometry"/>
      </mxCell>
    </object>
    <object label="Remote Access Server" ComponentGuid="6dfaa6bf-0f0d-4f90-ac5e-0f1afcff0b0c" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="2" id="11">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/remote_access_server.svg;labelBackgroundColor=none;" parent="2" vertex="1">
        <mxGeometry x="40" y="408" width="34" height="60" as="geometry"/>
      </mxCell>
    </object>
    <mxCell id="27" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="2" source="8" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="28" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="2" source="8" target="7" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="39" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="2" source="8" target="9" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="40" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="2" source="9" target="10" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="41" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="2" source="10" target="6" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="42" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="2" source="10" target="11" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <object SAL="High" label="Distributed Control System (DCS)-High" internalLabel="Distributed Control System (DCS)" ZoneType="Control System" zone="1" Criticality="Low" id="3">
      <mxCell style="swimlane;zone=1;labelBackgroundColor=none;fillColor=#d3eef2;swimlaneFillColor=#f2f8f9;" parent="1" vertex="1" connectable="0">
        <mxGeometry x="384" y="73" width="715" height="518" as="geometry"/>
      </mxCell>
    </object>
    <object label="DCS Firewall" ComponentGuid="a5f33082-fad1-4860-8bd3-95ec9002173f" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="12">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/firewall.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="39" y="203.5" width="60" height="51" as="geometry"/>
      </mxCell>
    </object>
    <object label="Operator Workstation" ComponentGuid="ae6ccc4e-0b5d-47f3-b972-119e1e45d592" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="13">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/hmi.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="289" y="123" width="60" height="50" as="geometry"/>
      </mxCell>
    </object>
    <object label="Server A" ComponentGuid="06cc100e-04b0-4831-aa04-118d5426a681" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="14">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/application_server.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="289" y="312" width="44" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="Server B" ComponentGuid="cf9f4b51-7010-4919-88ed-4b8ce8e0eea3" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="15">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/application_server.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="441" y="312" width="44" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="Internal Historian" ComponentGuid="9b177786-353f-4bba-a22f-e60c09d61020" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="16">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/historian.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="153" y="312" width="48" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="DCS 1" ComponentGuid="fe23455c-dcf0-4f37-90f1-8dea37956702" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="17">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/dcs.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="601" y="123" width="48" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="DCS 2" ComponentGuid="171ed4e7-d296-4c1b-9d50-8e82d4f09656" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="18">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/dcs.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="601" y="216.5" width="48" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="DCS 3" ComponentGuid="0b7ce43a-45bd-4e30-bf89-052ec4c76787" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="19">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/dcs.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="601" y="312" width="48" height="60" as="geometry"/>
      </mxCell>
    </object>
    <object label="DCS IDS" ComponentGuid="46f17cc1-d63c-4865-a675-22d32229c6cd" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="20">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/ids.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="156" y="123" width="60" height="17" as="geometry"/>
      </mxCell>
    </object>
    <object label="CON-2" ComponentGuid="477d3077-6648-4bf8-a647-c35e7550ab03" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" internalLabel="CON-2" id="21">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/connector.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="177" y="219" width="20" height="20" as="geometry"/>
      </mxCell>
    </object>
    <object label="Op Switch" ComponentGuid="55547555-3658-4f9d-b53b-e88170f8a14d" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="22">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/switch.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="289" y="216.5" width="60" height="23" as="geometry"/>
      </mxCell>
    </object>
    <object label="DCS Router" ComponentGuid="fdbec6d5-9c9c-4eb9-9730-8340b8f528c7" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" parent="3" id="23">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/router.svg;labelBackgroundColor=none;" parent="3" vertex="1">
        <mxGeometry x="441" y="216.5" width="60" height="25" as="geometry"/>
      </mxCell>
    </object>
    <mxCell id="24" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" target="20" edge="1" source="21">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="183" y="216" as="sourcePoint"/>
      </mxGeometry>
    </mxCell>
    <mxCell id="25" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="21" target="22" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="31" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="22" target="16" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="32" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="22" target="15" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="33" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="22" target="14" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="34" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="22" target="13" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="35" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="22" target="23" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="36" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="23" target="17" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="37" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="23" target="18" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="38" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="23" target="19" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="30" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="3" source="12" edge="1" target="21">
      <mxGeometry relative="1" as="geometry">
        <mxPoint x="177" y="227" as="targetPoint"/>
      </mxGeometry>
    </mxCell>
    <object label="Web" ComponentGuid="a1e43fc3-8cd8-4fc7-9ef1-7e5f4301124a" HasUniqueQuestions="" IPAddress="" Description="" Criticality="" HostName="" internalLabel="Web" id="4">
      <mxCell style="whiteSpace=wrap;html=1;image;image=img/cset/web.svg;labelBackgroundColor=none;" parent="1" vertex="1">
        <mxGeometry x="-39.879999999999995" y="98.60000000000002" width="60" height="60" as="geometry"/>
      </mxCell>
    </object>
    <mxCell id="26" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="1" source="4" target="5" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="29" style="rounded=0;orthogonalLoop=1;jettySize=auto;html=1;strokeColor=#808080;strokeWidth=1;endArrow=none;labelBackgroundColor=none;" parent="1" source="9" target="12" edge="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
  </root>
</mxGraphModel>' WHERE [Id] = 1

PRINT(N'Add constraints to [dbo].[SET_FILES]')
ALTER TABLE [dbo].[SET_FILES] WITH CHECK CHECK CONSTRAINT [FK_SET_FILES_GEN_FILE]
ALTER TABLE [dbo].[SET_FILES] WITH CHECK CHECK CONSTRAINT [FK_SET_FILES_SETS]

PRINT(N'Add constraints to [dbo].[NEW_REQUIREMENT]')
ALTER TABLE [dbo].[NEW_REQUIREMENT] CHECK CONSTRAINT [FK_NEW_REQUIREMENT_NCSF_Category]
ALTER TABLE [dbo].[NEW_REQUIREMENT] WITH CHECK CHECK CONSTRAINT [FK_NEW_REQUIREMENT_QUESTION_GROUP_HEADING]
ALTER TABLE [dbo].[NEW_REQUIREMENT] CHECK CONSTRAINT [FK_NEW_REQUIREMENT_STANDARD_CATEGORY]
ALTER TABLE [dbo].[FINANCIAL_REQUIREMENTS] WITH CHECK CHECK CONSTRAINT [FK_FINANCIAL_REQUIREMENTS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[NERC_RISK_RANKING] CHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_REQUIREMENT]
ALTER TABLE [dbo].[PARAMETER_REQUIREMENTS] CHECK CONSTRAINT [FK_Parameter_Requirements_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_LEVELS] CHECK CONSTRAINT [FK_REQUIREMENT_LEVELS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] WITH CHECK CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_REFERENCES] CHECK CONSTRAINT [FK_REQUIREMENT_REFERENCES_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_SETS] CHECK CONSTRAINT [FK_REQUIREMENT_SETS_NEW_REQUIREMENT]
ALTER TABLE [dbo].[REQUIREMENT_SOURCE_FILES] CHECK CONSTRAINT [FK_REQUIREMENT_SOURCE_FILES_NEW_REQUIREMENT]

PRINT(N'Add constraints to [dbo].[NEW_QUESTION]')
ALTER TABLE [dbo].[NEW_QUESTION] WITH CHECK CHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SAL_LEVEL]
ALTER TABLE [dbo].[NEW_QUESTION] WITH CHECK CHECK CONSTRAINT [FK_NEW_QUESTION_UNIVERSAL_SUB_CATEGORY_HEADINGS]
ALTER TABLE [dbo].[COMPONENT_QUESTIONS] CHECK CONSTRAINT [FK_Component_Questions_NEW_QUESTION]
ALTER TABLE [dbo].[FINANCIAL_QUESTIONS] WITH CHECK CHECK CONSTRAINT [FK_FINANCIAL_QUESTIONS_NEW_QUESTION]
ALTER TABLE [dbo].[NERC_RISK_RANKING] CHECK CONSTRAINT [FK_NERC_RISK_RANKING_NEW_QUESTION]
ALTER TABLE [dbo].[NEW_QUESTION_SETS] CHECK CONSTRAINT [FK_NEW_QUESTION_SETS_NEW_QUESTION]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS] CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_NEW_QUESTION1]
ALTER TABLE [dbo].[REQUIREMENT_QUESTIONS_SETS] WITH CHECK CHECK CONSTRAINT [FK_REQUIREMENT_QUESTIONS_SETS_NEW_QUESTION]
COMMIT TRANSACTION
GO