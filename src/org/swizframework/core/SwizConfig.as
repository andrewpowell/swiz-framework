package org.swizframework.core
{
	import flash.events.Event;
	import flash.events.EventPhase;
	
	public class SwizConfig implements ISwizConfig
	{
		// ========================================
		// protected static constants
		// ========================================
		
		/**
		 * Regular expression to evaluate a 'wildcard' (ex. 'org.swizframework.*') package description.
		 *
		 * Matches: package.*
		 * Captures: package
		 */
		protected static const WILDCARD_PACKAGE:RegExp = /\A(.*)(\.\**)\Z/;
		
		// ========================================
		// protected properties
		// ========================================
		
		/**
		 * Backing variable for the <code>strict</code> property.
		 */
		protected var _strict:Boolean = true;
		
		/**
		 * Backing variable for the <code>setUpEvent</code> property.
		 */
		protected var _setUpEventType:String = Event.ADDED_TO_STAGE;
		
		/**
		 * Backing variable for the <code>setUpEventPriority</code> property.
		 */
		protected var _setUpEventPriority:int = 50;
		
		/**
		 * Backing variable for the <code>setUpEventPhase</code> property.
		 */
		protected var _setUpEventPhase:uint = EventPhase.CAPTURING_PHASE;
		
		/**
		 * Backing variable for the <code>setUpMarkerFunction</code> property.
		 */
		protected var _setUpMarkerFunction:Function = null;
		
		/**
		 * Backing variable for the <code>tearDownEvent</code> property.
		 */
		protected var _tearDownEventType:String = Event.REMOVED_FROM_STAGE;
		
		/**
		 * Backing variable for the <code>tearDownEventPriority</code> property.
		 */
		protected var _tearDownEventPriority:int = 50;
		
		/**
		 * Backing variable for the <code>tearDownEventPhase</code> property.
		 */
		protected var _tearDownEventPhase:uint = EventPhase.CAPTURING_PHASE;
		
		/**
		 * Backing variable for the <code>eventPackages</code> property.
		 */
		protected var _eventPackages:Array = [];
		
		/**
		 * Backing variable for the <code>viewPackages</code> property.
		 */
		protected var _viewPackages:Array = [];
		
		/**
		 * Backing variable for the <code>defaultFaultHandler</code> property.
		 */
		protected var _defaultFaultHandler:Function;
		
		// ========================================
		// public properties
		// ========================================
		
		/**
		 * @inheritDoc
		 */
		public function get strict():Boolean
		{
			return _strict;
		}
		
		public function set strict( value:Boolean ):void
		{
			_strict = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get setUpEventType():String
		{
			return _setUpEventType;
		}
		
		public function set setUpEventType( value:String ):void
		{
			_setUpEventType = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get setUpEventPriority():int
		{
			return _setUpEventPriority;
		}
		
		public function set setUpEventPriority( value:int ):void
		{
			_setUpEventPriority = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get setUpEventPhase():uint
		{
			return _setUpEventPhase;
		}
		
		public function set setUpEventPhase( value:uint ):void
		{
			_setUpEventPhase = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get setUpMarkerFunction():Function
		{
			return _setUpMarkerFunction;
		}
		
		public function set setUpMarkerFunction( value:Function ):void
		{
			_setUpMarkerFunction = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get tearDownEventType():String
		{
			return _tearDownEventType;
		}
		
		public function set tearDownEventType( value:String ):void
		{
			_tearDownEventType = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get tearDownEventPriority():int
		{
			return _tearDownEventPriority;
		}
		
		public function set tearDownEventPriority( value:int ):void
		{
			_tearDownEventPriority = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get tearDownEventPhase():uint
		{
			return _tearDownEventPhase;
		}
		
		public function set tearDownEventPhase( value:uint ):void
		{
			_tearDownEventPhase = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get eventPackages():Array
		{
			return _eventPackages;
		}
		
		public function set eventPackages( value:* ):void
		{
			setEventPackages( value );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get viewPackages():Array
		{
			return _viewPackages;
		}
		
		public function set viewPackages( value:* ):void
		{
			setViewPackages( value );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get defaultFaultHandler():Function
		{
			return _defaultFaultHandler;
		}
		
		public function set defaultFaultHandler( faultHandler:Function ):void
		{
			_defaultFaultHandler = faultHandler;
		}
		
		// ========================================
		// constructor
		// ========================================
		
		/**
		 * Constructor
		 */
		public function SwizConfig()
		{
			super();
		}
		
		// ========================================
		// protected methods
		// ========================================
		
		/**
		 * Internal setter for <code>eventPackages</code> property.
		 *
		 * @param value An Array of Strings or a single String that will be split on ","
		 */
		protected function setEventPackages( value:* ):void
		{
			_eventPackages = parsePackageValue( value );
		}
		
		/**
		 * Internal setter for <code>viewPackages</code> property.
		 *
		 * @param value An Array of Strings or a single String that will be split on ","
		 */
		protected function setViewPackages( value:* ):void
		{
			_viewPackages = parsePackageValue( value );
		}
		
		/**
		 * Parses a wildcard type package property value into an Array of parsed package names.
		 *
		 * @param value An Array of Strings or a single String that will be split on ","
		 * @returns An Array of package name strings in a common format.
		 */
		protected function parsePackageValue( value:* ):Array
		{
			if( value == null )
			{
				return [];
			}
			else if( value is Array )
			{
				return parsePackageNames( value as Array );
			}
			else if( value is String )
			{
				return parsePackageNames( value.replace( /\ /g, "" ).split( "," ) );
			}
			else
			{
				throw new Error( "Package specified using unknown type. Supported types are Array or String." );
			}
		}
		
		/**
		 * Parses an array of package names.
		 * Processes the package names to a common format - removing trailing '.*' wildcard notation.
		 *
		 * @param packageNames The package names to parse.
		 * @returns An Array of the parsed package names.
		 */
		protected function parsePackageNames( packageNames:Array ):Array
		{
			var parsedPackageNames:Array = [];
			
			for each( var packageName:String in packageNames )
			{
				parsedPackageNames.push( parsePackageName( packageName ) );
			}
			
			return parsedPackageNames;
		}
		
		/**
		 * Parse Package Name
		 * Processes the package name to a common format - removing trailing '.*' wildcard notation.
		 *
		 * @param packageName The package name to parse.
		 * @returns The package name with the wildcard notation stripped.
		 */
		protected function parsePackageName( packageName:String ):String
		{
			var match:Object = WILDCARD_PACKAGE.exec( packageName );
			if( match )
				return match[ 1 ];
			
			return packageName;
		}
	}
}