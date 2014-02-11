require 'rubyXL/objects/ooxml_object'
require 'rubyXL/objects/simple_types'
require 'rubyXL/objects/extensions'
require 'rubyXL/objects/relationships'
require 'rubyXL/objects/sheet_common'
require 'rubyXL/objects/text'
require 'rubyXL/objects/formula'
require 'rubyXL/objects/sheet_data'
require 'rubyXL/objects/filters'
require 'rubyXL/objects/data_validation'

module RubyXL

  # Eventually, the entire code for Worksheet will be moved here. One small step at a time!

  # http://www.schemacentral.com/sc/ooxml/e-ssml_outlinePr-1.html
  class OutlineProperties < OOXMLObject
    define_attribute(:applyStyles,        :bool, :default => false)
    define_attribute(:summaryBelow,       :bool, :default => true)
    define_attribute(:summaryRight,       :bool, :default => true)
    define_attribute(:showOutlineSymbols, :bool, :default => true)
    define_element_name 'outlinePr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_pageSetUpPr-1.html
  class PageSetupProperties < OOXMLObject
    define_attribute(:autoPageBreaks, :bool, :default => true)
    define_attribute(:fitToPage,      :bool, :default => false)
    define_element_name 'pageSetUpPr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_sheetPr-3.html
  class WorksheetProperties < OOXMLObject
    define_attribute(:syncHorizontal,                    :bool, :default => false)
    define_attribute(:syncVertical,                      :bool, :default => false)
    define_attribute(:syncRef,                           :ref)
    define_attribute(:transitionEvaluation,              :bool, :default => false)
    define_attribute(:transitionEntry,                   :bool, :default => false)
    define_attribute(:published,                         :bool, :default => true)
    define_attribute(:codeName,                          :string)
    define_attribute(:filterMode,                        :bool, :default => false)
    define_attribute(:enableFormatConditionsCalculation, :bool, :default => true)
    define_child_node(RubyXL::Color, :node_name => :tabColor)
    define_child_node(RubyXL::OutlineProperties)
    define_child_node(RubyXL::PageSetupProperties)
    define_element_name 'sheetPr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_dimension-3.html
  class WorksheetDimensions < OOXMLObject
    define_attribute(:ref, :ref)
    define_element_name 'dimension'
  end

  class WorksheetFormatProperties < OOXMLObject
    define_attribute(:baseColWidth,     :int,   :default => 8)
    define_attribute(:defaultColWidth,  :float)
    define_attribute(:defaultRowHeight, :float, :required => true)
    define_attribute(:customHeight,     :bool,  :default => false)
    define_attribute(:zeroHeight,       :bool,  :default => false)
    define_attribute(:thickTop,         :bool,  :default => false)
    define_attribute(:thickBottom,      :bool,  :default => false)
    define_attribute(:outlineLevelRow,  :int,   :default => 0)
    define_attribute(:outlineLevelCol,  :int,   :default => 0)
    define_element_name 'sheetFormatPr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_pageSetup-1.html
  class PageSetup < OOXMLObject
    define_attribute(:paperSize,          :int,    :default => 1)
    define_attribute(:scale,              :int,    :default => 100)
    define_attribute(:firstPageNumber,    :int,    :default => 1)
    define_attribute(:fitToWidth,         :int,    :default => 1)
    define_attribute(:fitToHeight,        :int,    :default => 1)
    define_attribute(:pageOrder,          RubyXL::ST_PageOrder, :default => 'downThenOver')
    define_attribute(:orientation,        RubyXL::ST_Orientation, :default => 'default')
    define_attribute(:usePrinterDefaults, :bool,   :default => true)
    define_attribute(:blackAndWhite,      :bool,   :default => false)
    define_attribute(:draft,              :bool,   :default => false)
    define_attribute(:cellComments,       RubyXL::ST_CellComments, :default => 'none')
    define_attribute(:useFirstPageNumber, :bool,   :default => false)
    define_attribute(:errors,             RubyXL::ST_PrintError, :default => 'displayed')
    define_attribute(:horizontalDpi,      :int,    :default => 600)
    define_attribute(:verticalDpi,        :int,    :default => 600)
    define_attribute(:copies,             :int,    :default => 1)
    define_attribute(:'r:id',             :string)
    define_element_name 'pageSetup'
  end

  class TableParts < OOXMLObject
    define_child_node(RubyXL::RID, :collection => :with_count, :node_name => :table_part)
    define_element_name 'tableParts'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_mergeCell-1.html
  class MergedCell < OOXMLObject
    define_attribute(:ref, :ref)
    define_element_name 'mergeCell'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_mergeCells-1.html
  class MergedCells < OOXMLObject
    define_child_node(RubyXL::MergedCell, :collection => :with_count)
    define_element_name 'mergeCells'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_printOptions-1.html
  class PrintOptions < OOXMLObject
    define_attribute(:horizontalCentered, :bool, :default => false)
    define_attribute(:verticalCentered,   :bool, :default => false)
    define_attribute(:headings,           :bool, :default => false)
    define_attribute(:gridLines,          :bool, :default => false)
    define_attribute(:gridLinesSet,       :bool, :default => true)
    define_element_name 'printOptions'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_sheetCalcPr-1.html
  class SheetCalculationProperties < OOXMLObject
    define_attribute(:fullCalcOnLoad, :bool, :default => false)
    define_element_name 'sheetCalcPr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_protectedRange-1.html
  class ProtectedRange < OOXMLObject
    define_attribute(:password,           :string)
    define_attribute(:sqref,              :sqref, :required => true)
    define_attribute(:name,               :string, :required => true)
    define_attribute(:securityDescriptor, :string)
    define_element_name 'protectedRange'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_protectedRanges-1.html
  class ProtectedRanges < OOXMLObject
    define_child_node(RubyXL::ProtectedRange, :collection => true)
    define_element_name 'protectedRanges'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_sheetProtection-1.html
  class WorksheetProtection < OOXMLObject
    define_attribute(:password,            :string)
    define_attribute(:sheet,               :bool, :default => false)
    define_attribute(:objects,             :bool, :default => false)
    define_attribute(:scenarios,           :bool, :default => false)
    define_attribute(:formatCells,         :bool, :default => true)
    define_attribute(:formatColumns,       :bool, :default => true)
    define_attribute(:formatRows,          :bool, :default => true)
    define_attribute(:insertColumns,       :bool, :default => true)
    define_attribute(:insertRows,          :bool, :default => true)
    define_attribute(:insertHyperlinks,    :bool, :default => true)
    define_attribute(:deleteColumns,       :bool, :default => true)
    define_attribute(:deleteRows,          :bool, :default => true)
    define_attribute(:selectLockedCells,   :bool, :default => false)
    define_attribute(:sort,                :bool, :default => true)
    define_attribute(:autoFilter,          :bool, :default => true)
    define_attribute(:pivotTables,         :bool, :default => true)
    define_attribute(:selectUnlockedCells, :bool, :default => false)
    define_element_name 'sheetProtection'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cfvo-1.html
  class ConditionalFormatValue < OOXMLObject
    define_attribute(:type, RubyXL::ST_CfvoType, :required => true)
    define_attribute(:val,  :string)
    define_attribute(:gte,  :bool,   :default => true)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'cfvo'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_colorScale-1.html
  class ColorScale < OOXMLObject
    define_child_node(RubyXL::ConditionalFormatValue, :collection => true, :accessor => :cfvo)
    define_child_node(RubyXL::Color)
    define_element_name 'colorScale'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_dataBar-1.html
  class DataBar < OOXMLObject
    define_attribute(:minLength, :int,  :default => 10)
    define_attribute(:maxLength, :int,  :default => 90)
    define_attribute(:showValue, :bool, :default => true)
    define_child_node(RubyXL::ConditionalFormatValue, :collection => true, :accessor => :cfvo)
    define_child_node(RubyXL::Color)
    define_element_name 'dataBar'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_iconSet-1.html
  class IconSet < OOXMLObject
    define_attribute(:type,      RubyXL::ST_IconSetType, :required => true, :default => '3TrafficLights1')
    define_attribute(:showValue, :bool,   :default => true)
    define_attribute(:percent,   :bool,   :default => true)
    define_attribute(:reverse,   :bool,   :default => false)
    define_child_node(RubyXL::ConditionalFormatValue, :collection => true, :accessor => :cfvo)
    define_element_name 'iconSet'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cfRule-1.html
  class ConditionalFormattingRule < OOXMLObject
    define_attribute(:type,         RubyXL::ST_CfType)
    define_attribute(:dxfId,        :int)
    define_attribute(:priority,     :int,    :required => 1)
    define_attribute(:stopIfTrue,   :bool,   :default  => false)
    define_attribute(:aboveAverage, :bool,   :default  => true)
    define_attribute(:percent,      :bool,   :default  => false)
    define_attribute(:bottom,       :bool,   :default  => false)
    define_attribute(:operator,     RubyXL::ST_ConditionalFormattingOperator)
    define_attribute(:text,         :string)
    define_attribute(:timePeriod,   RubyXL::ST_TimePeriod)
    define_attribute(:rank,         :int)
    define_attribute(:stdDev,       :int)
    define_attribute(:equalAverage, :bool,   :default  => false)
    define_child_node(RubyXL::Formula, :collection => true, :node_name => :formula, :accessor => :formulas)
    define_child_node(RubyXL::ColorScale)
    define_child_node(RubyXL::DataBar)
    define_child_node(RubyXL::IconSet)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'cfRule'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_brk-1.html
  class Break < OOXMLObject
    define_attribute(:id,  :int,  :default => 0)
    define_attribute(:min, :int,  :default => 0)
    define_attribute(:max, :int,  :default => 0)
    define_attribute(:man, :bool, :default => false)
    define_attribute(:pt,  :bool, :default => false)
    define_element_name 'brk'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_rowBreaks-1.html
  class BreakList < OOXMLObject
    define_attribute(:manualBreakCount, :int, :default => 0)
    define_child_node(RubyXL::Break, :collection => :with_count)
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_conditionalFormatting-1.html
  class ConditionalFormatting < OOXMLObject
    define_attribute(:pivot, :bool, :default => false)
    define_attribute(:sqref, :sqref)
    define_child_node(RubyXL::ConditionalFormattingRule, :collection => true, :accessor => :cf_rules)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'conditionalFormatting'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_inputCells-1.html
  class InputCells < OOXMLObject
    define_attribute(:r,        :ref,    :required => true)
    define_attribute(:deleted,  :bool,   :default => false)
    define_attribute(:undone,   :bool,   :default => false)
    define_attribute(:val,      :string, :required => true)
    define_attribute(:numFmtId, :int)
    define_element_name 'inputCells'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_scenario-1.html
  class Scenario < OOXMLObject
    define_attribute(:name,    :string)
    define_attribute(:locked,  :bool, :default => false)
    define_attribute(:hidden,  :bool, :default => false)
    define_attribute(:user,    :string)
    define_attribute(:comment, :string)
    define_child_node(RubyXL::InputCells, :collection => :with_count)
    define_element_name 'scenario'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_scenarios-1.html
  class ScenarioContainer < OOXMLObject
    define_attribute(:current, :int)
    define_attribute(:show,    :int)
    define_attribute(:sqref,   :sqref)
    define_child_node(RubyXL::Scenario, :collection => true, :accessor => :scenarios)
    define_element_name 'scenarios'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_ignoredError-1.html
  class IgnoredError < OOXMLObject
    define_attribute(:sqref,              :sqref, :required => true)
    define_attribute(:pivot,              :bool,  :default  => false)
    define_attribute(:evalError,          :bool,  :default  => false)
    define_attribute(:twoDigitTextYear,   :bool,  :default  => false)
    define_attribute(:numberStoredAsText, :bool,  :default  => false)
    define_attribute(:formula,            :bool,  :default  => false)
    define_attribute(:formulaRange,       :bool,  :default  => false)
    define_attribute(:unlockedFormula,    :bool,  :default  => false)
    define_attribute(:emptyCellReference, :bool,  :default  => false)
    define_attribute(:listDataValidation, :bool,  :default  => false)
    define_attribute(:calculatedColumn,   :bool,  :default  => false)
    define_element_name 'ignoredError'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_ignoredErrors-1.html
  class IgnoredErrorContainer < OOXMLObject
    define_child_node(RubyXL::IgnoredError, :collection => true, :accessor => :ignored_errors)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'ignoredErrors'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_hyperlink-1.html
  class Hyperlink < OOXMLObject
    define_attribute(:ref,      :ref,    :required => true)
    define_attribute(:'r:id',   :string)
    define_attribute(:location, :string)
    define_attribute(:tooltip,  :string)
    define_attribute(:display,  :string)
    define_element_name 'hyperlink'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_hyperlinks-1.html
  class HyperlinkContainer < OOXMLObject
    define_child_node(RubyXL::Hyperlink, :colection => true, :accessor => :hyperlinks)
    define_element_name 'hyperlinks'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_oleObject-1.html
  class OLEObject < OOXMLObject
    define_attribute(:progId,    :string)
    define_attribute(:dvAspect,  RubyXL::ST_DvAspect, :default => 'DVASPECT_CONTENT')
    define_attribute(:link, :string)
    define_attribute(:oleUpdate, RubyXL::ST_OleUpdate)
    define_attribute(:autoLoad,  :bool, :default => false)
    define_attribute(:shapeId,   :int, :required => true)
    define_attribute(:'r:id',    :string)
    define_element_name 'oleObject'
  end                              

  # http://www.schemacentral.com/sc/ooxml/e-ssml_oleObjects-1.html
  class OLEObjects < OOXMLObject
    define_child_node(RubyXL::OLEObject, :colection => true, :accessor => :ole_objects)
    define_element_name 'oleObjects'
  end                              

  # http://www.schemacentral.com/sc/ooxml/e-ssml_dataRef-1.html
  class DataConsolidationReference < OOXMLObject
    define_attribute(:ref,    :ref)
    define_attribute(:name,   :string)
    define_attribute(:sheet,  :string)
    define_attribute(:'r:id', :string)
    define_element_name 'dataRef'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_dataRefs-1.html
  class DataConsolidationReferences < OOXMLObject
    define_child_node(RubyXL::DataConsolidationReference, :collection => :with_count, :accessor => :data_cons_ref)
    define_element_name 'dataRefs'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_dataConsolidate-1.html
  class DataConsolidate < OOXMLObject
    define_attribute(:function,   RubyXL::ST_DataConsolidateFunction, :default => 'sum')
    define_attribute(:leftLabels, :bool, :default => false)
    define_attribute(:topLabels,  :bool, :default => false)
    define_attribute(:link,       :bool, :default => false)
    define_child_node(RubyXL::DataConsolidationReferences, :accessor => :data_cons_ref_container)
    define_element_name 'dataConsolidate'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_pane-1.html
  class Pane < OOXMLObject
    define_attribute(:xSplit,      :int)
    define_attribute(:ySplit,      :int)
    define_attribute(:topLeftCell, :string)
    define_attribute(:activePane,  RubyXL::ST_Pane, :default => 'topLeft', )
    define_attribute(:state,       RubyXL::ST_PaneState, :default=> 'split')
    define_element_name 'pane'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_selection-1.html
  class Selection < OOXMLObject
    define_attribute(:pane,         RubyXL::ST_Pane)
    define_attribute(:activeCell,   :ref)
    define_attribute(:activeCellId, :int)   # 0-based index of @active_cell in @sqref
    define_attribute(:sqref,        :sqref) # Array of references to the selected cells.
    define_element_name 'selection'

    def before_write_xml
      # Normally, rindex of activeCellId in sqref:
      # <selection activeCell="E12" activeCellId="9" sqref="A4 B6 C8 D10 E12 A4 B6 C8 D10 E12"/>
      if @active_cell_id.nil? && !@active_cell.nil? && @sqref.size > 1 then
        # But, things can be more complex:
        # <selection activeCell="E8" activeCellId="2" sqref="A4:B4 C6:D6 E8:F8"/>
        # Not using .reverse.each here to avoid memory reallocation.
        @sqref.each_with_index { |ref, ind| @active_cell_id = ind if ref.cover?(@active_cell) } 
      end
      true
    end
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_customSheetView-1.html
  class CustomSheetView < OOXMLObject
    define_attribute(:guid,           :string, :required => true)
    define_attribute(:scale,          :int,    :default => 100)
    define_attribute(:colorId,        :int,    :default => 64)
    define_attribute(:showPageBreaks, :bool,   :default => false)
    define_attribute(:showFormulas,   :bool,   :default => false)
    define_attribute(:showGridLines,  :bool,   :default => true)
    define_attribute(:showRowCol,     :bool,   :default => true)
    define_attribute(:outlineSymbols, :bool,   :default => true)
    define_attribute(:zeroValues,     :bool,   :default => true)
    define_attribute(:fitToPage,      :bool,   :default => false)
    define_attribute(:printArea,      :bool,   :default => false)
    define_attribute(:filter,         :bool,   :default => false)
    define_attribute(:showAutoFilter, :bool,   :default => false)
    define_attribute(:hiddenRows,     :bool,   :default => false)
    define_attribute(:hiddenColumns,  :bool,   :default => false)
    define_attribute(:state,          RubyXL::ST_Visibility, :default => 'visible')
    define_attribute(:filterUnique,   :bool,   :default => false)
    define_attribute(:view,           RubyXL::ST_SheetViewType, :default => 'normal')
    define_attribute(:showRuler,      :bool,   :default => true)
    define_attribute(:topLeftCell,    :ref)
    define_child_node(RubyXL::Pane)
    define_child_node(RubyXL::Selection)
    define_child_node(RubyXL::BreakList, :node_name => :rowBreaks)
    define_child_node(RubyXL::BreakList, :node_name => :colBreaks)
    define_child_node(RubyXL::PageMargins)
    define_child_node(RubyXL::PrintOptions)
    define_child_node(RubyXL::PageSetup)
    define_child_node(RubyXL::HeaderFooterSettings)
    define_child_node(RubyXL::AutoFilter)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'customSheetView'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_customSheetViews-1.html
  class CustomSheetViews < OOXMLObject
    define_child_node(RubyXL::CustomSheetView, :collection => true, :accessor => :custom_sheet_view)
    define_element_name 'customSheetViews'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_control-1.html
  class EmbeddedControl < OOXMLObject
    define_attribute(:shapeId, :int,    :required => :true)
    define_attribute(:'r:id',  :string, :required => :true)
    define_attribute(:name,    :string)
    define_element_name 'control'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_controls-1.html
  class EmbeddedControlContainer < OOXMLObject
    define_child_node(RubyXL::EmbeddedControl, :collection => true, :accessor => :controls)
    define_element_name 'controls'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cellWatch-1.html
  class CellWatch < OOXMLObject
    define_attribute(:r, :ref)
    define_element_name 'cellWatch'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cellWatches-1.html
  class CellWatchContainer < OOXMLObject
    define_child_node(RubyXL::CellWatch, :collection => true, :accessor => :cell_watches)
    define_element_name 'cellWatches'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cellSmartTagPr-1.html
  class CellSmartTagProperty < OOXMLObject
    define_attribute(:key, :string, :required => :true)
    define_attribute(:val, :string, :required => :true)
    define_element_name 'cellSmartTagPr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cellSmartTag-1.html
  class CellSmartTag < OOXMLObject
    define_attribute(:type,     :int,  :required => :true)
    define_attribute(:deleted,  :bool, :default => false)
    define_attribute(:xmlBased, :bool, :default => false)
    define_child_node(RubyXL::CellSmartTagProperty, :collection => :true, :accessor => :smart_tag_props)
    define_element_name 'cellSmartTag'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_cellSmartTags-1.html
  class CellSmartTagContainer < OOXMLObject
    define_attribute(:r, :ref, :accessor => :ref)
    define_child_node(RubyXL::CellSmartTag, :collection => :true, :accessor => :cell_smart_tags)
    define_element_name 'cellSmartTags'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_smartTags-1.html
  class SmartTagContainer < OOXMLObject
    define_child_node(RubyXL::CellSmartTagContainer, :collection => :true, :accessor => :smart_tags)
    define_element_name 'smartTags'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_customPr-1.html
  class CustomProperty < OOXMLObject
    define_attribute(:name,   :string, :required => :true)
    define_attribute(:'r:id', :string, :required => :true)
    define_element_name 'customPr'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_customProperties-1.html
  class CustomPropertyContainer < OOXMLObject
    define_child_node(RubyXL::CustomProperty, :collection => :true, :accessor => :custom_props)
    define_element_name 'customProperties'
  end

  class FieldItem < OOXMLObject
    define_attribute(:v, :int, :required => true)
    define_element_name 'x'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_references-1.html
  class PivotReference < OOXMLObject
    define_attribute(:field,           :int)
    define_attribute(:selected,        :bool,   :default => true)
    define_attribute(:byPosition,      :bool,   :default => false)
    define_attribute(:relative,        :bool,   :default => false)
    define_attribute(:defaultSubtotal, :bool,   :default => false)
    define_attribute(:sumSubtotal,     :bool,   :default => false)
    define_attribute(:countASubtotal,  :bool,   :default => false)
    define_attribute(:avgSubtotal,     :bool,   :default => false)
    define_attribute(:maxSubtotal,     :bool,   :default => false)
    define_attribute(:minSubtotal,     :bool,   :default => false)
    define_attribute(:productSubtotal, :bool,   :default => false)
    define_attribute(:countSubtotal,   :bool,   :default => false)
    define_attribute(:stdDevSubtotal,  :bool,   :default => false)
    define_attribute(:stdDevPSubtotal, :bool,   :default => false)
    define_attribute(:varSubtotal,     :bool,   :default => false)
    define_attribute(:varPSubtotal,    :bool,   :default => false)
    define_child_node(RubyXL::FieldItem, :collection => :with_count, :accessor => :field_items)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'references'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_references-1.html
  class PivotReferenceContainer < OOXMLObject
    define_child_node(RubyXL::PivotReference, :collection => :with_count, :accessor => :pivot_references)
    define_element_name 'references'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_pivotArea-4.html
  class PivotArea < OOXMLObject
    define_attribute(:field,         :int)
    define_attribute(:type,          RubyXL::ST_PivotAreaType, :default => 'normal')
    define_attribute(:dataOnly,      :bool,   :default => true)
    define_attribute(:labelOnly,     :bool,   :default => false)
    define_attribute(:grandRow,      :bool,   :default => false)
    define_attribute(:grandCol,      :bool,   :default => false)
    define_attribute(:cacheIndex,    :bool,   :default => false)
    define_attribute(:outline,       :bool,   :default => true)
    define_attribute(:offset,        :ref)
    define_attribute(:collapsedLevelsAreSubtotals, :bool,   :default => false)
    define_attribute(:axis,          RubyXL::ST_Axis)
    define_attribute(:fieldPosition, :int,    :default => 0)
    define_child_node(RubyXL::PivotReferenceContainer, :accessor => :pivot_reference_container)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'pivotArea'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_pivotSelection-1.html
  class PivotTableSelection < OOXMLObject
    define_attribute(:pane,        RubyXL::ST_Pane, :default => 'topLeft')
    define_attribute(:showHeader,  :bool,   :default => false)
    define_attribute(:label,       :bool,   :default => false)
    define_attribute(:data,        :bool,   :default => false)
    define_attribute(:extendable,  :bool,   :default => false)
    define_attribute(:count,       :int,    :default => 0)
    define_attribute(:axis,        RubyXL::ST_Axis)
    define_attribute(:dimension,   :int,    :default => 0)
    define_attribute(:start,       :int,    :default => 0)
    define_attribute(:min,         :int,    :default => 0)
    define_attribute(:max,         :int,    :default => 0)
    define_attribute(:activeRow,   :int,    :default => 0)
    define_attribute(:activeCol,   :int,    :default => 0)
    define_attribute(:previousRow, :int,    :default => 0)
    define_attribute(:previousCol, :int,    :default => 0)
    define_attribute(:click,       :int,    :default => 0)
    define_attribute(:'r:id',      :string)
    define_child_node(RubyXL::PivotArea)
    define_element_name 'pivotSelection'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_sheetView-1.html
  class WorksheetView < OOXMLObject
    define_attribute(:windowProtection,         :bool,   :default => false)
    define_attribute(:showFormulas,             :bool,   :default => false)
    define_attribute(:showGridLines,            :bool,   :default => true)
    define_attribute(:showRowColHeaders,        :bool,   :default => true)
    define_attribute(:showZeros,                :bool,   :default => true)
    define_attribute(:rightToLeft,              :bool,   :default => false)
    define_attribute(:tabSelected,              :bool,   :default => false)
    define_attribute(:showRuler,                :bool,   :default => true)
    define_attribute(:showOutlineSymbols,       :bool,   :default => true)
    define_attribute(:defaultGridColor,         :bool,   :default => true)
    define_attribute(:showWhiteSpace,           :bool,   :default => true)
    define_attribute(:view,                     RubyXL::ST_SheetViewType, :default => 'normal')
    define_attribute(:topLeftCell,              :ref)
    define_attribute(:colorId,                  :int,    :default => 64)
    define_attribute(:zoomScale,                :int,    :default => 100)
    define_attribute(:zoomScaleNormal,          :int,    :default => 0)
    define_attribute(:zoomScaleSheetLayoutView, :bool,   :default => 0)
    define_attribute(:zoomScalePageLayoutView,  :bool,   :default => 0)
    define_attribute(:workbookViewId,           :int,    :required => true, :default => 0 )
    define_child_node(RubyXL::Pane)
    define_child_node(RubyXL::Selection, :collection => true, :accessor => :selections )
    define_child_node(RubyXL::PivotTableSelection, :collection => true, :accessor => :pivot_table_selections )
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'sheetView'
  end

  # http://www.schemacentral.com/sc/ooxml/e-ssml_sheetViews-3.html
  class WorksheetViews < OOXMLObject
    define_child_node(RubyXL::WorksheetView, :collection => true, :accessor => :sheet_views)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'sheetViews'
  end

  # http://www.schemacentral.com/sc/ooxml/s-sml-sheet.xsd.html
  class Worksheet < OOXMLTopLevelObject
    define_child_node(RubyXL::WorksheetProperties)
    define_child_node(RubyXL::WorksheetDimensions)
    define_child_node(RubyXL::WorksheetViews,           :accessor => :sheet_view_container)
    define_child_node(RubyXL::WorksheetFormatProperties)
    define_child_node(RubyXL::ColumnRanges)
    define_child_node(RubyXL::SheetData)
    define_child_node(RubyXL::SheetCalculationProperties)
    define_child_node(RubyXL::WorksheetProtection)
    define_child_node(RubyXL::ProtectedRanges)
    define_child_node(RubyXL::ScenarioContainer)
    define_child_node(RubyXL::AutoFilter)
    define_child_node(RubyXL::SortState)
    define_child_node(RubyXL::DataConsolidate)
    define_child_node(RubyXL::CustomSheetViews,         :accessor => :custom_sheet_view_container)
    define_child_node(RubyXL::MergedCells,              :accessor => :merged_cells_list)
    define_child_node(RubyXL::PhoneticProperties,       :accessor => :custom_props_container)
    define_child_node(RubyXL::ConditionalFormatting)
    define_child_node(RubyXL::DataValidations)
    define_child_node(RubyXL::HyperlinkContainer)
    define_child_node(RubyXL::PrintOptions)
    define_child_node(RubyXL::PageMargins)
    define_child_node(RubyXL::PageSetup)
    define_child_node(RubyXL::HeaderFooterSettings)
    define_child_node(RubyXL::BreakList,                :node_name => :rowBreaks)
    define_child_node(RubyXL::BreakList,                :node_name => :colBreaks)
    define_child_node(RubyXL::CustomPropertyContainer)
    define_child_node(RubyXL::CellWatchContainer,       :accessor => :cell_watch_container)
    define_child_node(RubyXL::IgnoredErrorContainer)
    define_child_node(RubyXL::SmartTagContainer,        :accessor => :smart_tag_container)
    define_child_node(RubyXL::RID,        :node_name => :drawing)
    define_child_node(RubyXL::RID,        :node_name => :legacyDrawing)
    define_child_node(RubyXL::RID,        :node_name => :legacyDrawingHF)
    define_child_node(RubyXL::RID,        :node_name => :picture)
    define_child_node(RubyXL::OLEObjects, :accessor  => :ole_object_container)
    define_child_node(RubyXL::EmbeddedControlContainer,   :accessor => :controls_container)
    define_child_node(RubyXL::WebPublishingItemContainer, :accessor => :web_items_container)
    define_child_node(RubyXL::TableParts)
    define_child_node(RubyXL::ExtensionStorageArea)
    define_element_name 'worksheet'
    set_namespaces('xmlns'       => 'http://schemas.openxmlformats.org/spreadsheetml/2006/main',
                   'xmlns:r'     => 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
                   'xmlns:mc'    => 'http://schemas.openxmlformats.org/markup-compatibility/2006',
                   'xmlns:x14ac' => 'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac',
                   'xmlns:mv'    => 'urn:schemas-microsoft-com:mac:vml')

    def before_write_xml # This method may need to be moved higher in the hierarchy
      first_nonempty_row = nil
      last_nonempty_row = 0
      first_nonempty_column = nil
      last_nonempty_column = 0

      if sheet_data then
        sheet_data.rows.each_with_index { |row, row_index|
          next if row.nil? || row.cells.empty?

          first_nonempty_cell = nil
          last_nonempty_cell = 0

          row.cells.each_with_index { |cell, col_index|
            next if cell.nil?
            cell.r = RubyXL::Reference.new(row_index, col_index)

            first_nonempty_cell ||= col_index
            last_nonempty_cell = col_index
          }

          if first_nonempty_cell then # If there's nothing in this row, then +first_nonempty_cell+ will be +nil+.
            last_nonempty_row = row_index
            first_nonempty_row ||= row_index

            first_nonempty_column ||= first_nonempty_cell
            last_nonempty_column = last_nonempty_cell if last_nonempty_cell > last_nonempty_column
          end

          row.r = row_index + 1
          row.spans = "#{first_nonempty_cell + 1}:#{last_nonempty_cell + 1}"
          row.custom_format = (row.s.to_i != 0)
        }

        if first_nonempty_row then
          self.dimension ||= RubyXL::WorksheetDimensions.new
          self.dimension.ref = RubyXL::Reference.new(first_nonempty_row, last_nonempty_row,
                                                     first_nonempty_column, last_nonempty_column)
        end

      end

      true
    end

    def merged_cells
      (merged_cells_list && merged_cells_list.merge_cell) || []
    end

    include LegacyWorksheet

  end

end