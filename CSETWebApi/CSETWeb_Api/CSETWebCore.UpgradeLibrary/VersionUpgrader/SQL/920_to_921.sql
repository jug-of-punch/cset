SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components]'
GO


ALTER VIEW [dbo].[Answer_Components]
AS
SELECT        Answer_Id, Assessment_Id, Mark_For_Review, Comment, Alternate_Justification, Is_Requirement, Question_Or_Requirement_Id, Question_Number, Answer_Text, Component_Guid, Is_Component, Is_Framework,
                          Reviewed, FeedBack
FROM            dbo.ANSWER
WHERE        (Is_Requirement = 0) AND (Is_Component = 1)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components_Exploded]'
GO

ALTER VIEW [dbo].[Answer_Components_Exploded]
AS

SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY a.Question_id)) as UniqueKey,
	a.Assessment_Id, b.Answer_Id, a.Question_Id, isnull(b.Answer_Text, c.Answer_Text) as Answer_Text, 
	CONVERT(nvarchar(1000), b.Comment) AS Comment, CONVERT(nvarchar(1000), b.Alternate_Justification) AS Alternate_Justification, 
	b.FeedBack,
	b.Question_Number, a.Simple_Question AS QuestionText, 	
	a.label AS ComponentName, a.Symbol_Name, 
	a.Question_Group_Heading, a.GroupHeadingId, 
	a.Universal_Sub_Category, a.SubCategoryId, 
	isnull(b.Is_Component,1) as Is_Component, a.Component_Guid, 
	a.Layer_Id, a.LayerName, a.Container_Id, 
	a.ZoneName, dbo.convert_sal(a.SAL) as SAL, 
	b.Mark_For_Review, Is_Requirement=cast(0 as bit), Is_Framework=cast(0 as bit),
	b.Reviewed, a.Simple_Question, a.Sub_Heading_Question_Description, a.heading_pair_id, a.label, a.Component_Symbol_Id
from (
SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	adc.Assessment_Id, q.Question_Id, q.Simple_Question,
	adc.label, adc.Component_Symbol_Id, 
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	adc.Component_Guid, adc.Layer_Id, l.Name AS LayerName, z.Container_Id, 
	z.Name AS ZoneName,  dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level)) AS SAL,
	h.Sub_Heading_Question_Description,h.Heading_Pair_Id, cs.Symbol_Name
from     dbo.ASSESSMENT_DIAGRAM_COMPONENTS AS adc 
			join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
			join dbo.COMPONENT_QUESTIONS AS cq ON adc.Component_Symbol_Id = cq.Component_Symbol_Id			
			join dbo.COMPONENT_SYMBOLS as cs on adc.Component_Symbol_Id = cs.Component_Symbol_Id
            join dbo.NEW_QUESTION AS q ON cq.Question_Id = q.Question_Id 
			join NEW_QUESTION_SETS s on q.Question_Id = s.Question_Id  and s.set_name = 'Components'
            join dbo.DIAGRAM_CONTAINER AS l ON adc.Layer_Id = l.Container_Id  
            left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id 
			left join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id
			left join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id
			join NEW_QUESTION_LEVELS nql on s.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal_short(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))		
WHERE l.Visible = 1) a left join Answer_Components AS b on a.Question_Id = b.Question_Or_Requirement_Id and a.Assessment_Id = b.Assessment_Id and a.component_guid = b.component_guid
left join (SELECT a.Assessment_Id, q.Question_Id, a.Answer_Text		
from   (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'						
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ss.Selected_Sal_Level)) as f  
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 			
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000') c on a.Assessment_Id=c.Assessment_Id and a.Question_Id = c.Question_Id




GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components_Default]'
GO




/**
The default consists of one one question 
joined on the types in the diagram
filtered by level 
left joined by the answers
*/
ALTER VIEW [dbo].[Answer_Components_Default]
AS

SELECT                   
	-- This guarantees a unique column to key on in the model
	CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	a.Assessment_Id, a.Answer_Id, q.Question_Id, a.Answer_Text, 
	CONVERT(nvarchar(1000), a.Comment) AS Comment, CONVERT(nvarchar(1000), a.Alternate_Justification) AS Alternate_Justification, 
	a.Question_Number, q.Simple_Question AS QuestionText, 		
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	a.FeedBack,
	a.Is_Component, a.Component_Guid, 
	dbo.convert_sal(ss.Selected_Sal_Level) AS SAL, 
	a.Mark_For_Review, a.Is_Requirement, a.Is_Framework,	
	q.heading_pair_id, h.Sub_Heading_Question_Description,
	q.Simple_Question, 
	a.Reviewed, label = null, ComponentName = null, Symbol_Name = null, Component_Symbol_id = 0
from   STANDARD_SELECTION ss
		 join 
		 (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'		
				join dbo.DIAGRAM_CONTAINER l on adc.Layer_id=l.Container_Id
				left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
				where l.visible = 1) as f  on ss.assessment_id=f.assessment_id							
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 
			join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
			join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		    
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000'
--order by question_group_heading,universal_sub_category
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components_Overrides]'
GO


ALTER VIEW [dbo].[Answer_Components_Overrides]
AS
/**
retreives only overriden component answers
so it is the same normal query but only returns 
those records where component guid is not null
*/
SELECT [UniqueKey]
      ,[Assessment_Id]
      ,[Answer_Id]
      ,[Question_Id]
      ,[Answer_Text]
      ,[Comment]
      ,[Alternate_Justification]
      ,[Question_Number]
      ,[QuestionText]
      ,[ComponentName]
      ,[Symbol_Name]
      ,[Question_Group_Heading]
      ,[GroupHeadingId]
      ,[Universal_Sub_Category]
      ,[SubCategoryId]
      ,[Is_Component]
      ,[Component_Guid]
      ,[Layer_Id]
      ,[LayerName]
      ,[Container_Id]
      ,[ZoneName]
      ,[SAL]
      ,[Mark_For_Review]
      ,[Is_Requirement]
      ,[Is_Framework]
      ,[Reviewed]
      ,[Simple_Question]
      ,[Sub_Heading_Question_Description]
      ,[heading_pair_id]
      ,[label]
      ,[Component_Symbol_Id]
	  ,[FeedBack]
  FROM [dbo].[Answer_Components_Exploded] where Answer_Id is not null
/*SELECT   distinct                
	-- This guarantees a unique column to key on in the model
	CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	a.Assessment_Id, a.Answer_Id, q.Question_Id, a.Answer_Text, 
	CONVERT(nvarchar(1000), a.Comment) AS Comment, CONVERT(nvarchar(1000), a.Alternate_Justification) AS Alternate_Justification, 
	a.Question_Number, nq.Simple_Question AS QuestionText, 		
	h.Question_Group_Heading, h.Universal_Sub_Category,
	a.Is_Component, adc.Component_Guid, 
	dbo.convert_sal(ss.Selected_Sal_Level) AS SAL, 
	a.Mark_For_Review, a.Is_Requirement, a.Is_Framework,
	nq.heading_pair_id, h.Sub_Heading_Question_Description,
	nq.Simple_Question,
	a.Reviewed, adc.Diagram_Component_Type, adc.label,

from   [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
		join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id				
		join component_questions q on adc.Diagram_Component_Type = q.Component_Type				
		join new_question nq on q.question_id=nq.question_id		
		join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'		
		join dbo.DIAGRAM_CONTAINER l on adc.Layer_id=l.Container_Id
		left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id
		join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
		and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))				        
		join dbo.vQUESTION_HEADINGS h on nq.Heading_Pair_Id = h.Heading_Pair_Id			    
		join Answer_Components AS a on q.Question_Id = a.Question_Or_Requirement_Id and ss.assessment_id = a.assessment_id	  
		where l.visible=1 and a.Component_Guid <> '00000000-0000-0000-0000-000000000000'*/
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
-- This statement writes to the SQL Server Log so SQL Monitor can show this deployment.
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @eventMessage = N'Redgate SQL Compare: { "deployment": { "description": "Redgate SQL Compare deployed to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ASSESSMENTS]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ASSESSMENTS] ADD
[AnalyzeDiagram] [bit] NOT NULL CONSTRAINT [DF__ASSESSMEN__Analy__188C8DD6] DEFAULT ((0))
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Assessments_For_User]'
GO

CREATE VIEW [dbo].[Assessments_For_User]
AS
select 	
    AssessmentId = a.Assessment_Id,
	AssessmentName = Assessment_Name,
	AssessmentCreatedDate,
	CreatorName = u.FirstName + ' ' + u.LastName,
	LastModifiedDate = LastAccessedDate,
	MarkedForReview = isnull(mark_for_review,0),
	c.UserId
	from ASSESSMENTS a 
		join INFORMATION i on a.Assessment_Id = i.Id
		join USERS u on a.AssessmentCreatorId = u.UserId
		join ASSESSMENT_CONTACTS c on a.Assessment_Id = c.Assessment_Id
		left join (select distinct a.Assessment_Id,Mark_For_Review from ASSESSMENTS a join Answer_Standards_InScope v on a.Assessment_Id = v.Assessment_Id 
				where v.Mark_For_Review = 1
			union 
			select distinct a.Assessment_Id,Mark_For_Review from ASSESSMENTS a join Answer_Components_InScope v on a.Assessment_Id = v.Assessment_Id 
			where v.Mark_For_Review = 1) b on a.Assessment_Id = b.Assessment_Id
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getExplodedComponent]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getExplodedComponent]
	-- Add the parameters for the stored procedure here
	@assessment_id int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY a.Question_id)) as UniqueKey,
	a.Assessment_Id, b.Answer_Id, a.Question_Id, isnull(b.Answer_Text, c.Answer_Text) as Answer_Text, 
	CONVERT(nvarchar(1000), b.Comment) AS Comment, CONVERT(nvarchar(1000), b.Alternate_Justification) AS Alternate_Justification, 
	b.FeedBack,
	b.Question_Number, a.Simple_Question AS QuestionText, 	
	a.label AS ComponentName, a.Symbol_Name, 
	a.Question_Group_Heading, a.GroupHeadingId, 
	a.Universal_Sub_Category, a.SubCategoryId, 
	isnull(b.Is_Component,1) as Is_Component, a.Component_Guid, 
	a.Layer_Id, a.LayerName, a.Container_Id, 
	a.ZoneName, dbo.convert_sal(a.SAL) as SAL, 
	b.Mark_For_Review, Is_Requirement=cast(0 as bit), Is_Framework=cast(0 as bit),
	b.Reviewed, a.Simple_Question, a.Sub_Heading_Question_Description, a.heading_pair_id, a.label, a.Component_Symbol_Id
from (
SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	adc.Assessment_Id, q.Question_Id, q.Simple_Question,
	adc.label, adc.Component_Symbol_Id, 
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	adc.Component_Guid, adc.Layer_Id, l.Name AS LayerName, z.Container_Id, 
	z.Name AS ZoneName,  dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level)) AS SAL,
	h.Sub_Heading_Question_Description,h.Heading_Pair_Id, cs.Symbol_Name
from	 dbo.ASSESSMENT_DIAGRAM_COMPONENTS AS adc
			join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
			join dbo.COMPONENT_QUESTIONS AS cq ON adc.Component_Symbol_Id = cq.Component_Symbol_Id			
			join dbo.COMPONENT_SYMBOLS as cs on adc.Component_Symbol_Id = cs.Component_Symbol_Id
            join dbo.NEW_QUESTION AS q ON cq.Question_Id = q.Question_Id 			
            join dbo.DIAGRAM_CONTAINER AS l ON adc.Layer_Id = l.Container_Id  
            left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id and adc.Assessment_Id=adc.Assessment_Id
			join (select s.*,nql.Universal_Sal_Level from NEW_QUESTION_SETS s
			join NEW_QUESTION_LEVELS nql on s.New_Question_Set_Id = nql.New_Question_Set_Id
			where set_name = 'Components' ) s on q.Question_Id = s.Question_Id and s.Universal_Sal_Level = dbo.convert_sal_short(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))		
			left join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id
			left join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		 
WHERE l.Visible = 1 and adc.Assessment_Id = @assessment_id) a left join Answer_Components AS b on a.Question_Id = b.Question_Or_Requirement_Id and a.Assessment_Id = b.Assessment_Id and a.component_guid = b.component_guid
left join (SELECT a.Assessment_Id, q.Question_Id, a.Answer_Text		
from   (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'						
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ss.Selected_Sal_Level)) as f  
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 			
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000') c on a.Assessment_Id=c.Assessment_Id and a.Question_Id = c.Question_Id
end 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_Answer_Components_Default]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Answer_Components_Default]
	-- Add the parameters for the stored procedure here
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT                   
		-- This guarantees a unique column to key on in the model
		cast(ROW_NUMBER() OVER (ORDER BY q.Question_id)as int) as UniqueKey,
		a.Assessment_Id, a.Answer_Id, q.Question_Id, a.Answer_Text, 
		CONVERT(nvarchar(1000), a.Comment) AS Comment, CONVERT(nvarchar(1000), a.Alternate_Justification) AS Alternate_Justification, 
		a.Question_Number, q.Simple_Question AS QuestionText, 		
		h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
		h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
		a.FeedBack,
		a.Is_Component, a.Component_Guid, 
		dbo.convert_sal(ss.Selected_Sal_Level) AS SAL, 
		a.Mark_For_Review, a.Is_Requirement, a.Is_Framework,	
		q.heading_pair_id, h.Sub_Heading_Question_Description,
		q.Simple_Question, 
		a.Reviewed, label = null, ComponentName = null, Symbol_Name = null, Component_Symbol_id = 0
	from   STANDARD_SELECTION ss
			 join 
			 (SELECT distinct q.question_id,adc.assessment_id
					FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
					join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
					join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
					join new_question nq on q.question_id=nq.question_id		
					join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'		
					join dbo.DIAGRAM_CONTAINER l on adc.Layer_id=l.Container_Id
					left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id
					join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
						and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
					where l.visible = 1) as f  on ss.assessment_id=f.assessment_id							
				join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 
				join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id	
				join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id		    
				join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
	where component_guid = '00000000-0000-0000-0000-000000000000' and a.Assessment_Id = @assessment_id
	order by Question_Group_Heading,Universal_Sub_Category
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[usp_getAnswerComponentOverrides]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getAnswerComponentOverrides]
	@assessment_id int
AS
BEGIN

		IF OBJECT_ID('tempdb..##componentExploded') IS NOT NULL DROP TABLE #componentExploded
	create table #componentExploded (UniqueKey int, Assessment_Id int, Answer_Id int, Question_Id int, Answer_Text varchar(50), Comment varchar(2048),
		Alternate_JustificaTion ntext, FeedBack varchar(2048), Question_Number int, QuestionText varchar(7338), ComponentName varchar(200), Symbol_Name varchar(100),
		Question_Group_Heading nvarchar(250), GroupHeadingId int, Universal_Sub_Category varchar(100), SubCategoryId int, Is_Component bit, Component_Guid uniqueidentifier,
		Layer_Id int, LayerName varchar(250),Container_Id int, ZoneName varchar(250), SAL varchar(20), Mark_For_Review bit, Is_Requirement bit,
		Is_Framework bit, Reviewed bit, Simple_Question varchar(7338), Sub_Heading_Question_Description varchar(200), heading_pair_id int,
		label varchar(200), Component_Symbol_Id int)
	insert into #componentExploded exec [usp_getExplodedComponent] @assessment_id

	SELECT [UniqueKey]
      ,[Assessment_Id]
      ,[Answer_Id]
      ,[Question_Id]
      ,[Answer_Text]
      ,[Comment]
      ,[Alternate_Justification]
      ,[Question_Number]
      ,[QuestionText]
      ,[ComponentName]
      ,[Symbol_Name]
      ,[Question_Group_Heading]
      ,[GroupHeadingId]
      ,[Universal_Sub_Category]
      ,[SubCategoryId]
      ,[Is_Component]
      ,[Component_Guid]
      ,[Layer_Id]
      ,[LayerName]
      ,[Container_Id]
      ,[ZoneName]
      ,[SAL]
      ,[Mark_For_Review]
      ,[Is_Requirement]
      ,[Is_Framework]
      ,[Reviewed]
      ,[Simple_Question]
      ,[Sub_Heading_Question_Description]
      ,[heading_pair_id]
      ,[label]
      ,[Component_Symbol_Id]
	  ,[FeedBack]
  FROM #componentExploded where Answer_Id is not null

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[Answer_Components_Exploded]'
GO


ALTER VIEW [dbo].[Answer_Components_Exploded]
AS

SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY a.Question_id)) as UniqueKey,
	a.Assessment_Id, b.Answer_Id, a.Question_Id, isnull(b.Answer_Text, c.Answer_Text) as Answer_Text, 
	CONVERT(nvarchar(1000), b.Comment) AS Comment, CONVERT(nvarchar(1000), b.Alternate_Justification) AS Alternate_Justification, 
	b.FeedBack,
	b.Question_Number, a.Simple_Question AS QuestionText, 	
	a.label AS ComponentName, a.Symbol_Name, 
	a.Question_Group_Heading, a.GroupHeadingId, 
	a.Universal_Sub_Category, a.SubCategoryId, 
	isnull(b.Is_Component,1) as Is_Component, a.Component_Guid, 
	a.Layer_Id, a.LayerName, a.Container_Id, 
	a.ZoneName, dbo.convert_sal(a.SAL) as SAL, 
	b.Mark_For_Review, Is_Requirement=cast(0 as bit), Is_Framework=cast(0 as bit),
	b.Reviewed, a.Simple_Question, a.Sub_Heading_Question_Description, a.heading_pair_id, a.label, a.Component_Symbol_Id
from (
SELECT CONVERT(varchar(100), ROW_NUMBER() OVER (ORDER BY q.Question_id)) as UniqueKey,
	adc.Assessment_Id, q.Question_Id, q.Simple_Question,
	adc.label, adc.Component_Symbol_Id, 
	h.Question_Group_Heading, usch.Question_Group_Heading_Id as GroupHeadingId, 
	h.Universal_Sub_Category, usch.Universal_Sub_Category_Id as SubCategoryId,
	adc.Component_Guid, adc.Layer_Id, l.Name AS LayerName, z.Container_Id, 
	z.Name AS ZoneName,  dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level)) AS SAL,
	h.Sub_Heading_Question_Description,h.Heading_Pair_Id, cs.Symbol_Name
from	 dbo.ASSESSMENT_DIAGRAM_COMPONENTS AS adc
			join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
			join dbo.COMPONENT_QUESTIONS AS cq ON adc.Component_Symbol_Id = cq.Component_Symbol_Id			
			join dbo.COMPONENT_SYMBOLS as cs on adc.Component_Symbol_Id = cs.Component_Symbol_Id
            join dbo.NEW_QUESTION AS q ON cq.Question_Id = q.Question_Id 			
            join dbo.DIAGRAM_CONTAINER AS l ON adc.Layer_Id = l.Container_Id  
            left join dbo.DIAGRAM_CONTAINER AS z ON adc.Zone_Id =z.Container_Id and adc.Assessment_Id=adc.Assessment_Id
			join (select s.*,nql.Universal_Sal_Level from NEW_QUESTION_SETS s
			join NEW_QUESTION_LEVELS nql on s.New_Question_Set_Id = nql.New_Question_Set_Id
			where set_name = 'Components' ) s on q.Question_Id = s.Question_Id and s.Universal_Sal_Level = dbo.convert_sal_short(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))		
			left join dbo.vQUESTION_HEADINGS h on q.Heading_Pair_Id = h.Heading_Pair_Id
			left join dbo.UNIVERSAL_SUB_CATEGORY_HEADINGS usch on usch.Heading_Pair_Id = h.Heading_Pair_Id
			 
WHERE l.Visible = 1) a left join Answer_Components AS b on a.Question_Id = b.Question_Or_Requirement_Id and a.Assessment_Id = b.Assessment_Id and a.component_guid = b.component_guid
left join (SELECT a.Assessment_Id, q.Question_Id, a.Answer_Text		
from   (SELECT distinct q.question_id,adc.assessment_id
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] adc 			
				join component_questions q on adc.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on adc.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id		
				join new_question_sets qs on nq.question_id=qs.question_id	and qs.Set_Name = 'Components'						
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id 
					and nql.Universal_Sal_Level = dbo.convert_sal(ss.Selected_Sal_Level)) as f  
            join dbo.NEW_QUESTION AS q ON f.Question_Id = q.Question_Id 			
			join Answer_Components AS a on f.Question_Id = a.Question_Or_Requirement_Id and f.assessment_id = a.assessment_id	  
where component_guid = '00000000-0000-0000-0000-000000000000') c on a.Assessment_Id=c.Assessment_Id and a.Question_Id = c.Question_Id




GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[GetCombinedOveralls]'
GO
ALTER PROCEDURE [dbo].[GetCombinedOveralls]	
@Assessment_Id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Generate temporary tables containing all relevant/in-scope answers for the Assessment	

	SELECT a.*
	into #questionAnswers
		FROM Answer_Questions a 
		join NEW_QUESTION c on a.Question_Or_Requirement_Id=c.Question_Id				
		join NEW_QUESTION_SETS s on c.Question_Id = s.Question_Id
		join [sets] ms on s.Set_Name = ms.Set_Name
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name 								
		join NEW_QUESTION_LEVELS l on s.New_Question_Set_Id = l.New_Question_Set_Id 
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where a.Assessment_Id = @assessment_id 
			and v.Selected = 1 
			and v.Assessment_Id = @assessment_id 
			and l.Universal_Sal_Level = ul.Universal_Sal_Level
	
	SELECT ar.*
	into #requirementAnswers
		FROM Answer_Requirements ar
		join NEW_REQUIREMENT r on ar.Question_Or_Requirement_Id = r.Requirement_Id
		join REQUIREMENT_SETS s on r.Requirement_Id = s.Requirement_Id
		join REQUIREMENT_LEVELS l on ar.Question_Or_Requirement_Id = l.Requirement_Id
		join [sets] ms on s.Set_Name = ms.Set_Name
		join AVAILABLE_STANDARDS v on s.Set_Name = v.Set_Name
		join STANDARD_SELECTION ss on v.Assessment_Id = ss.Assessment_Id
		join UNIVERSAL_SAL_LEVEL ul on ss.Selected_Sal_Level = ul.Full_Name_Sal
		where ar.Assessment_Id = @assessment_id 
			and v.Selected = 1 
			and v.Assessment_Id = @assessment_id 
			and l.Standard_Level = ul.Universal_Sal_Level
	
	
	IF OBJECT_ID('tempdb..##componentAnswers') IS NOT NULL DROP TABLE #componentAnswers
	create table #componentAnswers (UniqueKey int, Assessment_Id int, Answer_Id int, Question_Id int, Answer_Text varchar(50), Comment varchar(2048),
		Alternate_JustificaTion ntext, FeedBack varchar(2048), Question_Number int, QuestionText varchar(7338), ComponentName varchar(200), Symbol_Name varchar(100),
		Question_Group_Heading nvarchar(250), GroupHeadingId int, Universal_Sub_Category varchar(100), SubCategoryId int, Is_Component bit, Component_Guid uniqueidentifier,
		Layer_Id int, LayerName varchar(250),Container_Id int, ZoneName varchar(250), SAL varchar(20), Mark_For_Review bit, Is_Requirement bit,
		Is_Framework bit, Reviewed bit, Simple_Question varchar(7338), Sub_Heading_Question_Description varchar(200), heading_pair_id int,
		label varchar(200), Component_Symbol_Id int)
	insert into #componentAnswers exec [usp_getExplodedComponent] @assessment_id



	if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = '#assessmentAnswers')
		drop table #asessmentAnswers;
	create table #assessmentAnswers (answer_text varchar(50), assessment_id int, is_requirement bit, is_component bit, is_framework bit)


	-- Populate #assessmentAnswers from the correct source table
	declare @applicationMode varchar(50)
	exec dbo.GetApplicationModeDefault @assessment_id, @ApplicationMode output

	if(@ApplicationMode = 'Questions Based')
	begin		
		insert into #assessmentAnswers 
		select answer_text, assessment_id, is_requirement, is_component, is_framework 
		from #questionAnswers
	end
	else
	begin		
		insert into #assessmentAnswers 
		select answer_text, assessment_id, is_requirement, is_component, is_framework 
		from #requirementAnswers
	end

	-- Include component answers regardless of the application mode
	insert into #assessmentAnswers
		select answer_text, assessment_id, is_requirement, is_component, is_framework 
		from #componentAnswers


    -- Insert statements for procedure here
	SELECT StatType,isNull(Total,0) as Total, 
					cast(IsNull(Round((cast(([Y]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [Y],
					cast(IsNull(Round((cast(([N]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [N],
					cast(IsNull(Round((cast(([NA]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [NA],
					cast(IsNull(Round((cast(([A]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [A],
					cast(IsNull(Round((cast(([U]) as float)/(isnull(nullif(Total,0),1)))*100,0),0) as int) as [U],
					[Y] as [YCount],[N] as [NCount],[NA] as [NACount],[A] as [ACount],[U] as [UCount],
					--Value = (IsNull(cast(([Y]+[A]) as float)/((isnull(nullif(Total,0),1)-isnull([NA],0))),0))*100, 					
					Value = (cast(([Y]+[A]) as float)/ isnull(nullif((isnull(Total,0)-isnull([NA],0)),0),1))*100, 					
					
					--Value = cast(1 as float), 					
					TotalNoNA = isnull(Total,0)- isnull(NA,0)
		FROM 
		(
			select [StatType]='Overall', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  
				from (select t=1, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text 
				from #assessmentAnswers  -- !!! 
				where Assessment_Id  = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
			union
				select [StatType]='Requirement', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  		
				from (select t=2, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Requirement = 1 and assessment_id = @assessment_id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
			union
				select [StatType]='Questions', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  
				from (select t=3, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Requirement = 0 and Is_Component = 0 and Assessment_Id = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 	
			union
				select [StatType]='Components', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total  
				from (select t=4, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Requirement = 0 and Is_Component = 1 and Assessment_Id = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
			union
				select [StatType]='Framework', isnull(Acount,0) as Acount, aw.answer_text, SUM(acount) OVER(PARTITION BY aw.t) AS Total    
				from (select t=5, ANSWER_LOOKUP.Answer_Text from ANSWER_LOOKUP) aw left join (select count(answer_text) as Acount, answer_text
				from #assessmentAnswers 
				where Is_Framework = 1 and Assessment_Id = @Assessment_Id
				group by answer_Text) B on aw.Answer_Text=b.Answer_Text 
		) p
		PIVOT
		(
		sum(acount)
		FOR answer_text IN
		( [Y],[N],[NA],[A],[U] )
		) AS pvt
		ORDER BY pvt.StatType;

END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[FillNetworkDiagramQuestions]'
GO
-- =============================================
-- Author:		hansbk
-- Create date: 9/27/2019
-- Description:	calll to get defaults
-- =============================================
ALTER PROCEDURE [dbo].[FillNetworkDiagramQuestions]
	@assessment_id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SET NOCOUNT ON;

	  delete a from ANSWER a 
		left join (SELECT distinct q.question_id 
				FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] a 			
				join component_questions q on a.Component_Symbol_Id = q.Component_Symbol_Id
				join STANDARD_SELECTION ss on a.Assessment_Id = ss.Assessment_Id
				join new_question nq on q.question_id=nq.question_id
				join new_question_sets qs on nq.question_id=qs.question_id		
				left join dbo.DIAGRAM_CONTAINER AS z ON a.Zone_Id =z.Container_Id
				join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
				where a.assessment_id = @assessment_id and qs.Set_Name = 'Components') b on a.Question_Or_Requirement_Id = b.Question_Id and a.Assessment_Id = @assessment_id
		where b.Question_Id is null and Is_Component = 1 and Assessment_Id = @assessment_id 

    /*Rules for Component questions
	For the default questions 
	select the set of component types and questions associated with the component types
	then insert an answer for each unique question in that list. 
	this needs filterd for level

	the major dimensions are 
	*/
	--generate defaults 
	INSERT INTO [dbo].[ANSWER]  ([Is_Requirement],[Question_Or_Requirement_Id],[Answer_Text],[Is_Component],[Is_Framework],[Assessment_Id])   	  		
		select Is_Requirement = 0,Question_id, Answer_Text = 'U', Is_Component = '1', Is_Framework = 0, Assessment_Id = @Assessment_Id 
		from (select * from [ANSWER] where [Assessment_Id] = @assessment_id and [IS_COMPONENT] = 1) a 		
		right join 
		(SELECT distinct q.question_id 
		FROM [dbo].[ASSESSMENT_DIAGRAM_COMPONENTS] a 			
		join component_questions q on a.Component_Symbol_Id = q.Component_Symbol_Id
		join STANDARD_SELECTION ss on a.Assessment_Id = ss.Assessment_Id
		join new_question nq on q.question_id=nq.question_id
		join new_question_sets qs on nq.question_id=qs.question_id		
		left join dbo.DIAGRAM_CONTAINER AS z ON a.Zone_Id =z.Container_Id
		join NEW_QUESTION_LEVELS nql on qs.New_Question_Set_Id = nql.New_Question_Set_Id and nql.Universal_Sal_Level = dbo.convert_sal(ISNULL(z.Universal_Sal_Level, ss.Selected_Sal_Level))
		where a.assessment_id = @assessment_id and qs.Set_Name = 'Components'
		) t 		
		on a.Question_Or_Requirement_Id = t.question_id
		where assessment_id is null
		--and Question_Or_Requirement_Id not in 
		--(select [Question_Or_Requirement_Id] from [ANSWER] where [Assessment_Id] = @assessment_id and [Component_Guid] = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER))
END

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating index [NonClusteredIndex-Answers_Assessment_Id] on [dbo].[ANSWER]'
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-Answers_Assessment_Id] ON [dbo].[ANSWER] ([Assessment_Id])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
-- This statement writes to the SQL Server Log so SQL Monitor can show this deployment.
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @eventMessage = N'Redgate SQL Compare: { "deployment": { "description": "Redgate SQL Compare deployed to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
