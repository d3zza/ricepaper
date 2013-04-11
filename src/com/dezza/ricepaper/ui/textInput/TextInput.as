package com.dezza.ricepaper.ui.textInput
{

	import com.dezza.ricepaper.ui.core.UIControl;
	import com.dezza.ricepaper.ui.movieclip.LabelledStateRenderer;
	import com.dezza.ricepaper.util.DisplayObjectContainerUtil;


	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	/**
	 * @author derek
	 */
	public class TextInput extends UIControl implements ITextInput
	{

		protected var _textField : TextField;

		protected var _emptyTextValue : String = "";

		protected var _valid : Boolean;

		protected var _enabledState : String;


		public function TextInput(asset : DisplayObject)
		{
			super(asset);

			if ( asset is TextField )
			{
				_textField = asset as TextField;
			}
			else if ( asset is DisplayObjectContainer )
			{
				_textField = findTextField(asset as DisplayObjectContainer);
			}

			if (!_textField)
			{
				trace("WARNING no input textField found in " + asset + " or it's children");
				// create a textfield to prevent errors
				_textField = new TextField();
			}

			init();

			initStates();
		}


		public function get textField() : TextField
		{
			return _textField;
		}


		public function set textField(textField : TextField) : void
		{
			if ( textField ) _textField = textField;
		}


		public function get value() : String
		{
			return _textField.text;
		}


		public function set value(text : String) : void
		{
			_textField.text = text;
		}


		public function get emptyValue() : String
		{
			return _emptyTextValue;
		}


		public function set emptyValue(text : String) : void
		{
			if ( value == emptyValue )
			{
				value = text;
			}
			_emptyTextValue = text;
		}


		public function set valid(isValid : Boolean) : void
		{
			_valid = isValid;
			renderState(isValid ? TextInputState.VALID : TextInputState.INVALID);
		}


		public function get valid() : Boolean
		{
			return _valid;
		}


		public function get asDisplayObject() : DisplayObject
		{
			return this;
		}


		override public function set enabled(enabled : Boolean) : void
		{
			super.enabled = enabled;
			textField.mouseEnabled = textField.tabEnabled = textField.selectable = enabled;
			textField.type = enabled ? TextFieldType.INPUT : TextFieldType.DYNAMIC;

			if ( _enabledState == TextInputState.FOCUSED )
			{
				unfocus();
			}

			renderState(enabled ? _enabledState : TextInputState.DISABLED);
		}


		public function get hasValue() : Boolean
		{
			return value != "" && value != emptyValue;
		}


		/**
		 * Search for a <code>TextField</code> instance with type <code>TextFieldType.INPUT</code> in the asset or children of the asset
		 * 
		 * This adds a bit of flexibility to the way InputField assets can be structured
		 * 
		 * If there are more than one input TextFields (there shouldn't be!) the first one found is returned.
		 * 
		 * @return TextField instance
		 */
		protected function findTextField(asset : DisplayObjectContainer) : TextField
		{
			if (!asset) return null;

			// collect DisplayObjectContainers (recursively)
			var containers : Array = DisplayObjectContainerUtil.getChildContainers(asset, 11);

			var container : DisplayObjectContainer;

			for (var i : int = 0;i < containers.length;i++)
			{
				container = containers[i];

				for (var j : int = 0;j < container.numChildren;j++)
				{
					// trace( "child "+j+" in container:"+container+":"+ container.getChildAt(j) );
					if ( container.getChildAt(j) is TextField && (container.getChildAt(j) as TextField).type == TextFieldType.INPUT )
					{
						return container.getChildAt(j) as TextField;
					}
				}
			}
			// trace(this+".findTextField() no tf found");
			return null;
		}


		protected function init() : void
		{
			textField.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, 0, true);
			textField.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);
		}


		override protected function initStates() : void
		{
			super.initStates();

			if ( asset is MovieClip && (asset as MovieClip).totalFrames > 1 )
			{
				_stateRenderer = new LabelledStateRenderer((asset as MovieClip), TextInputState.STATES);
			}

			renderState(TextInputState.UNFOCUSED);
		}


		protected function onFocusIn(event : FocusEvent) : void
		{
			if ( value == emptyValue) value = "";
			renderState(TextInputState.FOCUSED);
		}


		protected function onFocusOut(event : FocusEvent) : void
		{
			if ( value == "") value = emptyValue;
			renderState(TextInputState.UNFOCUSED);
		}


		public function reset() : void
		{
			value = emptyValue;
		}


		public function focus() : void
		{
			if (!textField.stage )
			{
				trace(this + ".focus() fails because instance is not on display list");
				return;
			}

			if ( textField.length )
			{
				textField.stage.focus = textField;
				textField.setSelection(textField.length, textField.length);
			}
			else
			{
				// work around to set caret index on empty field
				textField.text = " ";
				textField.stage.focus = textField;
				textField.setSelection(textField.length, textField.length);
				textField.text = "";
			}
		}


		public function unfocus() : void
		{
			if (textField.stage )
			{
				textField.stage.focus = textField.stage;
			}
		}


		public function get state() : String
		{
			return enabled ? _enabledState : TextInputState.DISABLED;
		}


		protected function renderState(state : String) : void
		{
			if ( state != TextInputState.DISABLED )
			{
				_enabledState = state;
			}
			_stateRenderer.render(state);
		}


		override public function destroy() : void
		{
			if ( textField )
			{
				textField.removeEventListener(FocusEvent.FOCUS_IN, onFocusIn);
				textField.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
				_textField = null;
			}
		}
	}
}
