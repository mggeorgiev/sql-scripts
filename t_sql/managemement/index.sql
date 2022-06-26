select name, index_id, type, type_desc, is_disabled, object_id 
from sys.indexes WHERE object_id = OBJECT_ID('dbo.Roles') ;

-- Create a nonclustered index with or without a unique constraint
-- Or create a clustered index on table '[Roles]' in schema '[dbo]' in database '[occupations]'
CREATE /*UNIQUE or CLUSTERED*/ INDEX IX_RolesNames ON [occupations].[dbo].[Roles] ([Name] ASC) /*Change sort order as needed*/
GO