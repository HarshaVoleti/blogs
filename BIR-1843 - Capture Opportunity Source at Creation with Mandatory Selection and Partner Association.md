

**organization.Migration**
- create up/down migration to add new partnerId Column for leads table
- create a migration to add default value (client-led/ business-led) - discuss default value for existing leads if needed

 **LeadX.Api**
 **Models** 
 - update `NestLeadCreateRequest` model to add source and partnerIds
```
	NestLeadCreateRequest{
		...
		Source - String
		PartnerId - int
		...
	}
```
- **LeadDto**
```
Source - String
PartnerId - int
```
- **LeadFullResponseModel**, **NestLeadResponse**
```
Source - String
PartnerId - int
ParterName - String
```
**LeadsService.cs** 
- update `BulkCreateNestLeadsAsync()` function to support source and partnerIds in the temptable that is being created
```
	var tempTableName = $"[Organization].[NestLeadsTemp-{Guid.NewGuid()}-{DateTime.Now.Ticks}]";
	
	var dataTable = new DataTable();

	dataTable.Columns.AddRange(new[]
	{
	new DataColumn("NestId", typeof(long)),
	
	...
	new DataColumn("Source", typeof(String))
	
	new DataColumn("PartnerId", typeof(int))
	...
	});
```


**Endpoints:**
- GET - organizations/{{organizationId}}/nests/{{nestId}}/leads
- Response - 
```
{
	"data": [
		{
			"id": 2,
			"companyId": 1,
			"hitListTitle": null,
			"source": "Partner-Led"
			"partnerId": 1 
			"partnerName": "Partner company name" 
		}
	],
	"pageInfo": {
		"pageNumber": 1,
		"pageSize": 10,
		"totalItems": 1,
		"totalPages": 1
	}
}  
```