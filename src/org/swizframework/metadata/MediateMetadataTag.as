package org.swizframework.metadata
{
	import org.swizframework.reflection.BaseMetadataTag;
	import org.swizframework.reflection.IMetadataTag;
	
	/**
	 * Class to represent <code>[Mediate]</code> metadata tags.
	 */
	public class MediateMetadataTag extends BaseMetadataTag
	{
		// ========================================
		// protected properties
		// ========================================
		
		/**
		 * Backing variable for read-only <code>event</code> property.
		 */
		protected var _event:String;
		
		/**
		 * Backing variable for read-only <code>properties</code> property.
		 */
		protected var _properties:Array;
		
		/**
		 * Backing variable for read-only <code>view</code> property.
		 */
		protected var _view:Boolean = false;
		
		/**
		 * Backing variable for read-only <code>priority</code> property.
		 */
		protected var _priority:int = 0;
		
		/**
		 * Backing variable for read-only <code>stopPropagation</code> property.
		 */
		protected var _stopPropagation:Boolean = false;
		
		/**
		 * Backing variable for read-only <code>stopImmediatePropagation</code> property.
		 */
		protected var _stopImmediatePropagation:Boolean = false;
		
		// ========================================
		// public properties
		// ========================================
		
		/**
		 * Returns event attribute of [Mediate] tag.
		 * Refers to the event type that will trigger the decorated method.
		 * Is the default attribute, meaning [Mediate( "someEvent" )] is
		 * equivalent to [Mediate( event="someEvent" )].
		 */
		public function get event():String
		{
			return _event;
		}
		
		/**
		 * Returns properties attribute of [Mediate] tag as an <code>Array</code>.
		 * Lists properties that will be pulled off of the event object and passed
		 * to the decorated method.
		 */
		public function get properties():Array
		{
			return _properties;
		}
		
		/**
		 * Returns view attribute of [Mediate] tag as a <code>Boolean</code>.
		 * If true instructs Swiz to create a listener on the specified view
		 * type whenever one is added to the display list.
		 *
		 * @default false
		 */
		public function get view():Boolean
		{
			return _view;
		}
		
		/**
		 * Returns priority attribute of [Mediate] tag.
		 * Synonymous to the priority argument of <code>flash.events.addEventListener</code>.
		 */
		public function get priority():int
		{
			return _priority;
		}
		
		/**
		 * Returns stopPropagation attribute of [Mediate] tag as a <code>Boolean</code>.
		 * Synonymous to the stopPropagation argument of <code>flash.events.addEventListener</code>.
		 *
		 * @default false
		 */
		public function get stopPropagation():Boolean
		{
			return _stopPropagation;
		}
		
		/**
		 * Returns stopImmediatePropagation attribute of [Mediate] tag as a <code>Boolean</code>.
		 * Synonymous to the stopImmediatePropagation argument of <code>flash.events.addEventListener</code>.
		 *
		 * @default false
		 */
		public function get stopImmediatePropagation():Boolean
		{
			return _stopImmediatePropagation;
		}
		
		// ========================================
		// constructor
		// ========================================
		
		/**
		 * Constructor sets <code>defaultArgName</code>.
		 */
		public function MediateMetadataTag()
		{
			defaultArgName = "event";
		}
		
		// ========================================
		// protected methods
		// ========================================
		
		/**
		 * Initialize properties based on values provided in [Mediate] tag.
		 */
		override public function copyFrom( metadataTag:IMetadataTag ):void
		{
			// super will set name, args and host for us
			super.copyFrom( metadataTag );
			
			// event is the default attribute
			// [Mediate( "someEvent" )] == [Mediate( event="someEvent" )]
			if( hasArg( "event" ) )
				_event = getArg( "event" ).value;
			
			if( hasArg( "properties" ) )
				_properties = getArg( "properties" ).value.replace( /\ /g, "" ).split( "," );
			
			if( hasArg( "view" ) )
				_view = getArg( "view" ).value == "true";
			
			if( hasArg( "priority" ) )
				_priority = int( getArg( "priority" ).value );
			
			if( hasArg( "stopPropagation" ) )
				_stopPropagation = getArg( "stopPropagation" ).value == "true";
			
			if( hasArg( "stopImmediatePropagation" ) )
				_stopImmediatePropagation = getArg( "stopImmediatePropagation" ).value == "true";
		}
	}
}