# Note
====

Create date:|2014-12-03
-|-
Author:|jebai
Website:|none

### Configuration
====

Environment|IP address
-|-
Development:|api.dribbble.com
Testing:|api.dribbble.com
Production:|api.dribbble.com

### API
====


#### Notes

* __[/notes](/notes)__

	___(null)___

	+ ___Request___

		Name|Type
		-|-
			page|___INT___
			per_page|___INT___

	+ ___Response___

		Name|Type
		-|-
			notes|___[Note*]___
			page|___INT___
			pages|___INT___
			per_page|___INT___
			total|___INT___


* __[/notes/:id](/notes/:id)__

	___(null)___

	+ ___Request___

		Name|Type
		-|-

	+ ___Response___

		Name|Type
		-|-
			RESP_NOTES_ID|___Note*___



### Model
====

* __Note__

	Name|Type
	-|-
		content|___TEXT___
		created_at|___TEXT___
		title|___TEXT___
		id|___INT___


