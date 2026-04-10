# Below is a template, map the project to this app_spec REPLACING THE CLAUDE APP - line by line no less no more
<ui_layout>
    <main_structure>
      - Three-column layout: sidebar (conversations), main (chat), panel (artifacts)
      - Collapsible sidebar with resize handle
      - Responsive breakpoints: mobile (single column), tablet (two column), desktop (three column)
      - Persistent header with project/model selector
      - Bottom input area with send button and options
    </main_structure>

    <sidebar_left>
      - New chat button (prominent)
      - Project selector dropdown
      - Search conversations input
      - Conversations list (grouped by date: Today, Yesterday, Previous 7 days, etc.)
      - Folder tree view (collapsible)
      - Settings gear icon at bottom
      - User profile at bottom
    </sidebar_left>

    <main_chat_area>
      - Conversation title (editable inline)
      - Model selector badge
      - Message history (scrollable)
      - Welcome screen for new conversations
      - Suggested prompts (empty state)
      - Input area with formatting toolbar
      - Attachment button for images
      - Send button with loading state
      - Stop generation button
    </main_chat_area>

    <artifacts_panel>
      - Artifact header with title and type badge
      - Code editor or preview pane
      - Tabs for multiple artifacts
      - Full-screen toggle
      - Download button
      - Edit/Re-prompt button
      - Version selector
      - Close panel button
    </artifacts_panel>

    <modals_overlays>
      - Settings modal (tabbed interface)
      - Share conversation modal
      - Export options modal
      - Project settings modal
      - Prompt library modal
      - Command palette overlay
      - Keyboard shortcuts reference
    </modals_overlays>
  </ui_layout>

  <design_system>
    <color_palette>
      - Primary: Orange/amber accent (#CC785C claude-style)
      - Background: White (light mode), Dark gray (#1A1A1A dark mode)
      - Surface: Light gray (#F5F5F5 light), Darker gray (#2A2A2A dark)
      - Text: Near black (#1A1A1A light), Off-white (#E5E5E5 dark)
      - Borders: Light gray (#E5E5E5 light), Dark gray (#404040 dark)
      - Code blocks: Monaco editor theme
    </color_palette>

    <typography>
      - Sans-serif system font stack (Inter, SF Pro, Roboto, system-ui)
      - Headings: font-semibold
      - Body: font-normal, leading-relaxed
      - Code: Monospace (JetBrains Mono, Consolas, Monaco)
      - Message text: text-base (16px), comfortable line-height
    </typography>

    <components>
      <message_bubble>
        - User messages: Right-aligned, subtle background
        - Assistant messages: Left-aligned, no background
        - Markdown formatting with proper spacing
        - Inline code with bg-gray-100 background
        - Code blocks with syntax highlighting
        - Copy button on code blocks
      </message_bubble>

      <buttons>
        - Primary: Orange/amber background, white text, rounded
        - Secondary: Border style with hover fill
        - Icon buttons: Square with hover background
        - Disabled state: Reduced opacity, no pointer events
      </buttons>

      <inputs>
        - Rounded borders with focus ring
        - Textarea auto-resize
        - Placeholder text in gray
        - Error states in red
        - Character counter
      </inputs>

      <cards>
        - Subtle border or shadow
        - Rounded corners (8px)
        - Padding: p-4 to p-6
        - Hover state: slight shadow increase
      </cards>
    </components>

    <animations>
      - Smooth transitions (150-300ms)
      - Fade in for new messages
      - Slide in for sidebar
      - Typing indicator animation
      - Loading spinner for generation
      - Skeleton loaders for content
    </animations>
  </design_system>

  <key_interactions>
    <message_flow>
      1. User types message in input field
      2. Optional: Attach images via button
      3. Click send or press Enter
      4. Message appears in chat immediately
      5. Typing indicator shows while waiting
      6. Response streams in word by word
      7. Code blocks render with syntax highlighting
      8. Artifacts detected and rendered in side panel
      9. Message complete, enable regenerate option
    </message_flow>

    <artifact_flow>
      1. Assistant generates artifact in response
      2. Artifact panel slides in from right
      3. Content renders (code with highlighting or live preview)
      4. User can edit artifact inline
      5. "Re-prompt" button to iterate with Claude
      6. Download or copy artifact content
      7. Full-screen mode for detailed work
      8. Close panel to return to chat focus
    </artifact_flow>

    <conversation_management>
      1. Click "New Chat" to start fresh conversation
      2. Conversations auto-save with first message
      3. Auto-generate title from first exchange
      4. Click title to rename inline
      5. Drag conversations into folders
      6. Right-click for context menu (pin, archive, delete, export)
      7. Search filters conversations in real-time
      8. Click conversation to switch context
    </conversation_management>
  </key_interactions>

  <implementation_steps>
    <step number="1">
      <title>Setup Project Foundation and Database</title>
      <tasks>
        - Initialize Express server with SQLite database
        - Set up Claude API client with streaming support
        - Create database schema with migrations
        - Implement authentication endpoints
        - Set up basic CORS and middleware
        - Create health check endpoint
      </tasks>
    </step>

    <step number="2">
      <title>Build Core Chat Interface</title>
      <tasks>
        - Create main layout with sidebar and chat area
        - Implement message display with markdown rendering
        - Add streaming message support with SSE
        - Build input area with auto-resize textarea
        - Add code block syntax highlighting
        - Implement stop generation functionality
        - Add typing indicators and loading states
      </tasks>
    </step>

    <step number="3">
      <title>Conversation Management</title>
      <tasks>
        - Create conversation list in sidebar
        - Implement new conversation creation
        - Add conversation switching
        - Build conversation rename functionality
        - Implement delete with confirmation
        - Add conversation search
        - Create conversation grouping by date
      </tasks>
    </step>

    <step number="4">
      <title>Artifacts System</title>
      <tasks>
        - Build artifact detection from Claude responses
        - Create artifact rendering panel
        - Implement code artifact viewer
        - Add HTML/SVG live preview
        - Build artifact editing interface
        - Add artifact versioning
        - Implement full-screen artifact view
      </tasks>
    </step>

    <step number="5">
      <title>Projects and Organization</title>
      <tasks>
        - Create projects CRUD endpoints
        - Build project selector UI
        - Implement project-specific custom instructions
        - Add folder system for conversations
        - Create drag-and-drop organization
        - Build project settings panel
      </tasks>
    </step>

    <step number="6">
      <title>Advanced Features</title>
      <tasks>
        - Add model selection dropdown
        - Implement temperature and parameter controls
        - Build image upload functionality
        - Create message editing and regeneration
        - Add conversation branching
        - Implement export functionality
      </tasks>
    </step>

    <step number="7">
      <title>Settings and Customization</title>
      <tasks>
        - Build settings modal with tabs
        - Implement theme switching (light/dark)
        - Add custom instructions management
        - Create keyboard shortcuts
        - Build prompt library
        - Add usage tracking dashboard
      </tasks>
    </step>

    <step number="8">
      <title>Sharing and Collaboration</title>
      <tasks>
        - Implement conversation sharing with tokens
        - Create public share view
        - Add export to multiple formats
        - Build prompt templates
        - Create example conversations
      </tasks>
    </step>

    <step number="9">
      <title>Polish and Optimization</title>
      <tasks>
        - Optimize for mobile responsiveness
        - Add command palette (Cmd+K)
        - Implement comprehensive keyboard navigation
        - Add onboarding flow
        - Create accessibility improvements
        - Performance optimization and caching
      </tasks>
    </step>
  </implementation_steps>

  <success_criteria>
    <functionality>
      - Streaming chat responses work smoothly
      - Artifact detection and rendering accurate
      - Conversation management intuitive and reliable
      - Project organization clear and useful
      - Image upload and display working
      - All CRUD operations functional
    </functionality>

    <user_experience>
      - Interface matches claude.ai design language
      - Responsive on all device sizes
      - Smooth animations and transitions
      - Fast response times and minimal lag
      - Intuitive navigation and workflows
      - Clear feedback for all actions
    </user_experience>

    <technical_quality>
      - Clean, maintainable code structure
      - Proper error handling throughout
      - Secure API key management
      - Optimized database queries
      - Efficient streaming implementation
      - Comprehensive testing coverage
    </technical_quality>

    <design_polish>
      - Consistent with claude.ai visual design
      - Beautiful typography and spacing
      - Smooth animations and micro-interactions
      - Excellent contrast and accessibility
      - Professional, polished appearance
      - Dark mode fully implemented
    </design_polish>
  </success_criteria>
</project_specification>