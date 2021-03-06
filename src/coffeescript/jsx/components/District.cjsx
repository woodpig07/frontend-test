React = require "react"
classNames = require "classnames"
Township = require "./Township.cjsx"

District = React.createClass

  getInitialState: ->
    {expanded: !@props.hidden}

  componentWillReceiveProps: (nextProps) ->
    if @props.displayLevel isnt nextProps.displayLevel or !@props.parentExpanded
      @setState
        expanded: false

  handleClick: (event) ->
    status = not @state.expanded
    @setState
      expanded: status  

  render: ->
    district = @props.district
    displayLevel = @props.displayLevel
    dClassNames = classNames "table-row", {hidden: @props.hidden}
    toggleClass = classNames "subitem-toggle", {expanded: @state.expanded, collapsed: !@state.expanded}
    townshipHidden = do =>
      if displayLevel is "Township"
        return false
      else
        return !@state.expanded

    if district.sub_records and district.sub_records.length > 0
      township_num = district.sub_records.length
      townships = district.sub_records.map (t)=>
        return <Township key={t.id} township={t} hidden={townshipHidden} />

      return <div>
          <div className={dClassNames}>
            <div className="table-cell">
              <div className="item-title item-district">
                <span className="icon icon-tag icon-prepend"> D </span>
                {district.title} 
                <span className="icon icon-download icon-append"> </span>
                <div className={toggleClass} onClick={@handleClick}>
                  <span> {township_num} </span>
                  Townships
                </div>
              </div>             
            </div>
            <div className="table-cell"> {district.last_inpot} </div>
            <div className="table-cell"> {district.form_num} </div>
            <div className="table-cell"> {district.voter_num} </div>
            <div className="table-cell"> {district.update} </div>
          </div>
          {townships}
        </div>

    else  
      return <div className={dClassNames}>
            <div className="table-cell">
              <div className="item-title item-district">
                <span className="icon icon-tag icon-prepend"> D </span>
                {district.title} 
                <span className="icon icon-download icon-append"> </span>
              </div>  
            </div>
            <div className="table-cell"> {district.last_inpot} </div>
            <div className="table-cell"> {district.form_num} </div>
            <div className="table-cell"> {district.voter_num} </div>
            <div className="table-cell"> {district.update} </div>
          </div>

module.exports = District          