#tag Window
Begin Window IndexProgress
   BackColor       =   16777215
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   7
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   140
   ImplicitInstance=   True
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Please Wait"
   Visible         =   True
   Width           =   300
   Begin ProgressBar ProgressBar1
      AutoDeactivate  =   True
      BehaviorIndex   =   0
      ControlOrder    =   0
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Maximum         =   100
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      Top             =   60
      Value           =   0
      Visible         =   True
      Width           =   260
   End
   Begin Label lbl_top
      AutoDeactivate  =   True
      BehaviorIndex   =   1
      Bold            =   False
      ControlOrder    =   1
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   12
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Building index:"
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "Arial"
      TextSize        =   10
      Top             =   16
      Underline       =   False
      Visible         =   True
      Width           =   260
   End
   Begin Label lbl_book
      AutoDeactivate  =   True
      BehaviorIndex   =   2
      Bold            =   False
      ControlOrder    =   2
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   15
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   24
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "Arial"
      TextSize        =   10
      Top             =   36
      Underline       =   False
      Visible         =   True
      Width           =   256
   End
   Begin Label lbl_bottom
      AutoDeactivate  =   True
      BehaviorIndex   =   3
      Bold            =   False
      ControlOrder    =   3
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Press 'esc' to cancel"
      TextAlign       =   2
      TextColor       =   0
      TextFont        =   "Arial"
      TextSize        =   10
      Top             =   102
      Underline       =   False
      Visible         =   False
      Width           =   260
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  App.DebugWriter.Write "IndexProgress.CancelClose"
		  If Not appQuitting Then
		    If Not cancelRequested Then
		      cancelRequested = True
		      cancelDelivered = False
		    End If
		    Return Not cancelDelivered
		  Else
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  App.DebugWriter.Write "IndexProgress.Close"
		  cancelRequested = true
		  cancelDelivered = False
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  App.DebugWriter.Write "IndexProgress.KeyDown"
		  if Keyboard.AsyncKeyDown(&h35)  Or Asc(Key) = 27 then
		    cancelRequested = true
		    cancelDelivered = False
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  App.DebugWriter.Write "IndexProgress.Open"
		  App.T.TranslateWindow Me, "index_progress", App.TranslationFonts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function cancel() As Boolean
		  If cancelRequested Then
		    cancelDelivered = True
		  End If
		  Return cancelRequested
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub doClose()
		  //++
		  // This is necessary because just calling Close
		  // isn't going to work.  The flags have to allow
		  // the close before it'll work.  This sets those
		  // flags and makes the close happen.
		  //--
		  
		  cancelRequested = True
		  cancelDelivered = True
		  Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setProgress(percent as Integer, book as String)
		  App.DebugWriter.Write "IndexProgress.setProgress"
		  ProgressBar1.Value= percent
		  lbl_book.Text=book
		  UpdateNow
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected cancelDelivered As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected cancelRequested As boolean
	#tag EndProperty


#tag EndWindowCode

