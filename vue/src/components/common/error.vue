<script lang="coffee">
import { last, snakeCase } from 'lodash'

export default
  props: ['error']
  data: ->
    exception: null
  mounted: ->
    @error.json().then (body) =>
      @exception = snakeCase(last(body['exception'].split('::')))
</script>
<template lang="pug">
v-main.pb-12
  v-container
    .error-page.text-center
      .error-page__forbidden(v-t="'error_page.' + exception" v-if="exception")
      .error-page__forbidden(v-t="'error_page.forbidden'" v-if="error.status == 403")
      .error-page__page-not-found(v-t="'error_page.page_not_found'" v-if="error.status == 404")
      .error-page__internal-server-error(v-t="'error_page.internal_server_error'" v-if="error.status == 500")
</template>
