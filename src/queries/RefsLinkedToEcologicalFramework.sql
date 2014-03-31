select r.Id, r.ReferenceCode, UnitCode, r.LifecycleState, rua.LifecycleState, Title, LastUpdated, EntryValue 
from dbo.Reference r inner join 
dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries t on t.ThesaurusId = rsca.ThesaurusEntryId
inner join dbo.ReferenceUnitAgreement rua on rua.ReferenceId = r.Id 
inner join dbo.Unit u on u.Id = rua.UnitId
where t.ThesaurusId = 1
and r.LifecycleState = 'Active'
and rua.LifecycleState in ('Approved', 'Pending')
and UnitCode = 'IMDP'
order by UnitCode


select r.Id, r.ReferenceCode, (select *  from dbo.GetProtocolUnitList(r.ReferenceCode)) as Units, r.LifecycleState, Title, LastUpdated, EntryValue from dbo.Reference r inner join 
dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries t on t.ThesaurusId = rsca.ThesaurusEntryId
where t.ThesaurusId = 1
and r.LifecycleState = 'Active'

-- On INP2300FCSWUPA5\IRMAITG
select r.ReferenceCode, u.UnitCode, r.LifecycleState
, rua.LifecycleState, Title, LastUpdated
, EntryValue, uu.Feature2 as UnitPoly 
from dbo.Reference r 
inner join dbo.ReferenceUnitAgreement rua on rua.ReferenceId = r.Id 
inner join dbo.Unit u on u.Id = rua.UnitId
inner join dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries te on te.Id = rsca.ThesaurusEntryId
inner join Unit.dbo.Unit uu on uu.Code = u.UnitCode
where 
r.LifecycleState = 'Active'
and u.UnitCode <> 'IMDP'
order by u.UnitCode, EntryValue

select r.ReferenceCode, u.UnitCode, r.LifecycleState
, rua.LifecycleState, Title, LastUpdated
, EntryValue, uu.Feature2 as UnitPoly 
from dbo.Reference r 
inner join dbo.ReferenceUnitAgreement rua on rua.ReferenceId = r.Id 
inner join dbo.Unit u on u.Id = rua.UnitId
inner join dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries te on te.Id = rsca.ThesaurusEntryId
inner join Unit.dbo.Unit uu on uu.Code = u.UnitCode
where 
r.LifecycleState = 'Active'
and rua.LifecycleState = 'Approved'
and u.UnitCode <> 'IMDP'
order by u.UnitCode, EntryValue

-- Monitoring Framework Values with Active, Approved Protocols
select distinct(EntryValue)
from dbo.Reference r 
inner join dbo.ReferenceUnitAgreement rua on rua.ReferenceId = r.Id 
inner join dbo.Unit u on u.Id = rua.UnitId
inner join dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries te on te.Id = rsca.ThesaurusEntryId
where 
r.LifecycleState = 'Active'
and rua.LifecycleState = 'Approved'
and u.UnitCode <> 'IMDP'
order by EntryValue

--- Vital Sign-specific Protocols
select r.ReferenceCode, u.UnitCode, r.LifecycleState
, rua.LifecycleState, Title, LastUpdated
, EntryValue, 'https://irma.nps.gov/App/Reference/Profile/' + CONVERT(varchar, r.ReferenceCode) as ProtocolLink,  uu.Feature2 as UnitPoly 
from dbo.Reference r 
inner join dbo.ReferenceUnitAgreement rua on rua.ReferenceId = r.Id 
inner join dbo.Unit u on u.Id = rua.UnitId
inner join dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries te on te.Id = rsca.ThesaurusEntryId
inner join Unit.dbo.Unit uu on uu.Code = u.UnitCode
where 
r.LifecycleState = 'Active'
and rua.LifecycleState = 'Approved'
and u.UnitCode <> 'IMDP'
and te.EntryValue = 'Air and Climate | Air Quality | Ozone'
and uu.Feature2 is not NULL


select r.ReferenceCode, u.UnitCode, r.LifecycleState
, rua.LifecycleState, Title, LastUpdated
, EntryValue, uu.Feature2 as UnitPoly 
from dbo.Reference r 
inner join dbo.ReferenceUnitAgreement rua on rua.ReferenceId = r.Id 
inner join dbo.Unit u on u.Id = rua.UnitId
inner join dbo.ReferenceSubjectCategoryAgreement rsca on rsca.ReferenceId = r.Id
inner join dbo.ThesaurusEntries te on te.Id = rsca.ThesaurusEntryId
inner join Unit.dbo.Unit uu on uu.Code = u.UnitCode
where 
r.LifecycleState = 'Active'
and rua.LifecycleState = 'Approved'
and u.UnitCode <> 'IMDP'
and te.EntryValue = 'Air and Climate | Air Quality | Ozone'
and uu.Feature2 is not NULL
order by u.UnitCode, EntryValue;